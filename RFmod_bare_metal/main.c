#include "stm8_pt6311.h"
#include "stm8s_delay.h"
#include "mbs74t1aef.h"
#include "stm8s.h"
#include "swi2c.h"

/*
 *  Software controller for MBS74T1AEF with user interface with VFD display (HL-D898W) board from sat. tuner and three buttons.
 *	UP button toggles on/off functions, or moves channel/frequency up, STATUS button changes screen view, DOWN button moves channel/frequency down. 
 *  Device uses internal EEPROM to save user data, if required, otherwise defaults to channel 21 and D/K sound system
 *
 *  tested on stm8s103f3p6 chip
 *  Created on: 12. 9. 2026
 *  Author: Adam Fucik
 *  
 */
 
//macros for buttons
#define UP_BTN_PORT  PC
#define UP_BTN_PIN   PIN4
#define STATUS_BTN_PORT   PC
#define STATUS_BTN_PIN PIN3
#define DOWN_BTN_PORT  PA
#define DOWN_BTN_PIN  PIN3
//readers
#define UP_BTN_READ()      ((PORT(UP_BTN_PORT, IDR) & UP_BTN_PIN) ? 1 : 0)
#define STATUS_BTN_READ()  ((PORT(STATUS_BTN_PORT, IDR) & STATUS_BTN_PIN) ? 1 : 0)
#define DOWN_BTN_READ()    ((PORT(DOWN_BTN_PORT, IDR) & DOWN_BTN_PIN) ? 1 : 0)
// Constants for acceleration
#define DEBOUNCE_MS         10
#define INITIAL_REPEAT_DELAY_MS  500   //autorepeat
#define INITIAL_REPEAT_INTERVAL_MS 450 // first repeat
#define MIN_REPEAT_INTERVAL_MS     5  // fastest repeat
#define ACCEL_FACTOR         4        // repeat divider
//memory start addr
#define EEPROM_START       0x4000
//freq + channel macros
#define RF_FREQ_MIN_KHZ          45000
#define RF_FREQ_MAX_KHZ         880000
#define RF_FREQ_STEP_KHZ           250
//channel frequencies in khz
#define CH21_FREQ_KHZ           471250
#define CH21_LAST_FREQ_KHZ      871250
#define CH6_FREQ_KHZ            175250
#define CH12_FREQ_KHZ           223250
#define CH3_FREQ_KHZ             77250
#define CH5_FREQ_KHZ             93250
#define CH1_FREQ_KHZ             49750
#define CH2_FREQ_KHZ             59250
//all toggleable screens in enum
typedef enum {
		frequency_state=0,
    channel_state,
		sound_state,
		ps_ratio_state,
		tpen_state,
		pwc_state,
		memory_state
} ScreenState;
//sound enum
typedef enum {
    MN_4_5MHZ = 0,
    BG_5_5MHZ,
    I_6_0MHZ,
    DK_6_5MHZ
} RFMod_sound_system;
//last memory conf enum
typedef struct {
    uint32_t frequency;
    uint8_t  ps_ratio;
    uint8_t  tpen;
    uint8_t  pwc;
    uint8_t  sound;
} Data_Memory;
//button speeder
typedef struct {
    uint8_t last_raw;         
    uint8_t stable;            
    uint8_t pressed;          
    uint32_t debounce_start;   
    uint32_t press_start;    
    uint32_t last_repeat;     
    uint16_t repeat_interval;  
} ButtonAccel;
//simple debounce eunm
typedef struct {
    uint8_t last_raw;
    uint8_t stable;
    uint32_t debounce_start;
} ButtonSimple;
//global vars
ScreenState current_screen;
RFModulator mod;
static volatile uint32_t tim4_ms_counter = 0;
//aliases for nonblocking buttons
ButtonAccel up_btn, down_btn;
ButtonSimple status_btn;
//shitter
uint8_t i;
//all data from mod defualts
uint32_t mod_frequency = 471250;
bool ps_ratio = 0;
bool tpen = 0;
bool pwc = 0;
uint8_t channel, last_channel = 21;
RFMod_sound_system sound = DK_6_5MHZ;

bool change_tracker = false;

void button_accel_init(ButtonAccel *btn);
void button_simple_init(ButtonSimple *btn);
uint8_t button_accel_check(uint8_t raw, ButtonAccel *btn);
uint8_t button_simple_check(uint8_t raw, ButtonSimple *btn);

void clock_setup(void);
void tim4_isr_setup(void);
void memory_handler(bool write);//memory saver
//screens - each matches different toggleable modulator configuration
void frequency_screen(void);
void channel_screen(void);
void sound_screen(void);
void ps_ratio_screen(void);
void tpen_screen(void);
void pwc_screen(void);
void memory_screen(void);
//st button checker
void check_st_button(void);
void btn_init(void);
//screen updater
void update_screen(void);

void freq_visuals(uint32_t frequency);
void freq_update_visuals(uint8_t move, uint16_t step_khz);
void channel_update_visuals(uint8_t move);
void channel_recalculate(uint32_t mod_frequency);
void bool_updaters(ScreenState screen);
void sound_system(RFMod_sound_system value);

@far @interrupt void timer4_isr(void)
{
    ++tim4_ms_counter; 
    TIM4_SR &= (uint8_t)(~TIM_SR1_UIF);
}

void main(void)
{
		clock_setup();//init main clock + timer
		tim4_isr_setup();//nonblocking delay
		btn_init();
		button_accel_init(&up_btn);
		button_accel_init(&down_btn);
		button_simple_init(&status_btn);
		pt6311_init(9);
		pt6311_set_display_state(PT6311_DISPLAY_ON);//prevent bugs
		for (i = 1; i < 10; i++)
		{
        pt6311_write_digit(i, 0xFFFFFF); 
				delay_ms(200);
		}
		delay_ms(300);
		pt6311_clear_display();
		pt6311_write_string(1,"TVTXV1-0 ");
		delay_ms(1200);
		pt6311_clear_display();	
		swi2c_init();
		RFModulator_Init(&mod, MC44BS374T1_ADDR);//start with defaults
		memory_handler(0); //load last data
		current_screen = frequency_state;//force current screen
		//force to display data directy to avoid errors
		pt6311_write_string(1,"F");
		freq_visuals(mod_frequency);
		while (1) {
			update_screen();
			check_st_button();
		}
}
void btn_init(void){//init three buttons as pu no it
		PORT(UP_BTN_PORT, DDR) &= ~UP_BTN_PIN;
    PORT(UP_BTN_PORT, CR1) |= UP_BTN_PIN;
    PORT(UP_BTN_PORT, CR2) &= ~UP_BTN_PIN;
		PORT(DOWN_BTN_PORT, DDR) &= ~DOWN_BTN_PIN;
    PORT(DOWN_BTN_PORT, CR1) |= DOWN_BTN_PIN;
    PORT(DOWN_BTN_PORT, CR2) &= ~DOWN_BTN_PIN;
		PORT(STATUS_BTN_PORT, DDR) &= ~STATUS_BTN_PIN;
    PORT(STATUS_BTN_PORT, CR1) |= STATUS_BTN_PIN;
    PORT(STATUS_BTN_PORT, CR2) &= ~STATUS_BTN_PIN;
}
//eeprom memory helpers
static void eeprom_unlock(void)
{
    if (!(FLASH_IAPSR & FLASH_IAPSR_DUL)) {
        FLASH_DUKR = FLASH_DUKR_KEY1;
        FLASH_DUKR = FLASH_DUKR_KEY2;

        while (!(FLASH_IAPSR & FLASH_IAPSR_DUL));
    }
}
static void eeprom_lock(void)
{
    FLASH_IAPSR &= (uint8_t)~FLASH_IAPSR_DUL;
}
static void eeprom_write_byte(uint16_t addr, uint8_t value)
{
    eeprom_unlock();

    *(volatile uint8_t *)addr = value;

    while (!(FLASH_IAPSR & FLASH_IAPSR_EOP));

    eeprom_lock();
}
static uint8_t eeprom_read_byte(uint16_t addr)
{
    return *(volatile uint8_t *)addr;
}
static void eeprom_write(uint16_t addr, const uint8_t *data, uint8_t len)
{
    uint8_t i;

    eeprom_unlock();

    for (i = 0; i < len; i++) {
        *(volatile uint8_t *)addr++ = data[i];

        while (!(FLASH_IAPSR & FLASH_IAPSR_EOP));
    }

    eeprom_lock();
}
static void eeprom_read(uint16_t addr, uint8_t *data, uint8_t len)
{
    uint8_t i;

    for (i = 0; i < len; i++) {
        data[i] = *(volatile uint8_t *)addr++;
    }
}
//memory handling
void memory_handler(bool write) {
	Data_Memory M;
	if (write){
    M.frequency = (uint32_t) mod_frequency;
    M.ps_ratio  = (bool)ps_ratio;
    M.tpen      = (bool)tpen;
    M.pwc       = (bool)pwc;
    M.sound     = (uint8_t)sound;
    eeprom_write(EEPROM_START,
                 (uint8_t *)&M,
                 sizeof(Data_Memory));
	}
	else{
    eeprom_read(EEPROM_START,
                (uint8_t *)&M,
                sizeof(Data_Memory));
		if (M.frequency < RF_FREQ_MIN_KHZ ||//some validation here
        M.frequency > RF_FREQ_MAX_KHZ ||
        M.sound > DK_6_5MHZ) {
				mod_frequency = 471250;
        ps_ratio = 0;
        tpen = 0;
        pwc = 0;
        sound = DK_6_5MHZ;
        RFModulator_SetFrequency(&mod, mod_frequency);
			}
		else{
        mod_frequency = M.frequency;
        ps_ratio = M.ps_ratio;
        tpen     = M.tpen;
        pwc      = M.pwc;
        sound    = (RFMod_sound_system)M.sound;

        RFModulator_SetFrequency(&mod, mod_frequency);
        RFModulator_SetPictureSoundRatio(&mod, ps_ratio);
        RFModulator_SetSoundSubcarrier(&mod, sound);
        RFModulator_SetPeakWhiteClip(&mod, pwc);
        RFModulator_SetTestPattern(&mod, tpen);
    } 
	}
}
static void question_writer(void){//write ?
		pt6311_write_digit(6, 0x1051);
		pt6311_write_digit(7, 0x000000);
}
//last data saver
void memory_screen(void){
	if (!change_tracker){
			pt6311_write_string(1,"SAVE ");
			question_writer();
			change_tracker=true;
		}
    if (button_accel_check(UP_BTN_READ(), &up_btn)) {
        memory_handler(1);
				//indicate
				pt6311_write_string(6,"OK");
				pt6311_write_digit(0, 128);
				delay_ms(300);
				pt6311_write_string(1,"SAVE");
				question_writer();
				pt6311_write_digit(0, 0x000000);
    } 
}
//init button speeder func
void button_accel_init(ButtonAccel *btn) {
    btn->last_raw = 1;
    btn->stable = 1;
    btn->pressed = 0;
    btn->debounce_start = 0;
    btn->press_start = 0;
    btn->last_repeat = 0;
    btn->repeat_interval = INITIAL_REPEAT_INTERVAL_MS;
}
//check speeding
uint8_t button_accel_check(uint8_t raw, ButtonAccel *btn)
{
    uint32_t now = tim4_ms_counter;

    if (raw != btn->last_raw) {
        btn->last_raw = raw;
        btn->debounce_start = now;
    }

    if ((uint32_t)(now - btn->debounce_start) >= DEBOUNCE_MS) {
        btn->stable = raw;
    }

    if (btn->stable == 0 && !btn->pressed) {
        btn->pressed = 1;
        btn->press_start = now;
        btn->last_repeat = now;
        btn->repeat_interval = INITIAL_REPEAT_INTERVAL_MS;
        return 1;
    }

    if (btn->stable == 0 && btn->pressed) {
        if ((uint32_t)(now - btn->press_start) >= INITIAL_REPEAT_DELAY_MS) {

            if ((uint32_t)(now - btn->last_repeat) >= btn->repeat_interval) {
                btn->last_repeat = now;

                if (btn->repeat_interval > MIN_REPEAT_INTERVAL_MS) {
                    btn->repeat_interval =
                        (uint16_t)((btn->repeat_interval * 8) / 10);

                    if (btn->repeat_interval < MIN_REPEAT_INTERVAL_MS) {
                        btn->repeat_interval = MIN_REPEAT_INTERVAL_MS;
                    }
                }

                return 1;
            }
        }
    }

    if (btn->stable == 1 && btn->pressed) {
        btn->pressed = 0;
    }

    return 0;
}

void button_simple_init(ButtonSimple *btn) {
    btn->last_raw = 1;
    btn->stable = 1;
    btn->debounce_start = 0;
}
uint8_t button_simple_check(uint8_t raw, ButtonSimple *btn)
{
    uint32_t now = tim4_ms_counter;

    if (raw != btn->last_raw) {
        btn->last_raw = raw;
        btn->debounce_start = now;
    }

    if ((uint32_t)(now - btn->debounce_start) >= DEBOUNCE_MS) {
        if (btn->stable != raw) {
            btn->stable = raw;

            if (btn->stable == 0) {
                return 1;
            }
        }
    }

    return 0;
}

void clock_setup(void)
	{
		CLK_CKDIVR = 0;
  }
	
void tim4_isr_setup(void) {
    TIM4_CR1 &= ~TIM_CR1_CEN;    
    TIM4_PSCR = 0x07;  
    TIM4_ARR = 124;    
		TIM4_CNTR = 0;
		TIM4_SR &= ~TIM_SR1_UIF;
    TIM4_IER |= TIM_IER_UIE;
    TIM4_CR1 |= TIM_CR1_CEN;
    enableInterrupts();
}
/*//lock indicator, because memory constraints, Im not using it
static void lock_reader(void){
	bool lock;
	lock = !((RFModulator_GetStatus(&mod) >> 0) & 1);
	if (lock){
		pt6311_write_digit(0, 8192);
	}
	else{
		pt6311_write_digit(0, 0x000000);
	}
}
*/
void check_st_button(void) {
        if (button_simple_check(STATUS_BTN_READ(), &status_btn)) {
            current_screen++;
						change_tracker=false;//track static changes, avoid refreshing not needed stuff
            if (current_screen > memory_state) {
                current_screen = frequency_state;
            }
            pt6311_clear_display();	
		}
}

void update_screen(void) {
    switch (current_screen) {
				case frequency_state:
            frequency_screen();
            break;
			
				case channel_state:
            channel_screen();
            break;
						
        case sound_state:
            sound_screen();
            break;
						
        case ps_ratio_state:
            ps_ratio_screen();
            break;
            
        case tpen_state:
            tpen_screen();
            break;
            
        case pwc_state:
            pwc_screen();
            break;
				
				case memory_state:
            memory_screen();
            break;		
						
        default:
            current_screen = frequency_state;
            break;
    }
}

void freq_visuals(uint32_t mod_frequency){//onetime frequency load
	uint16_t frec1;
	int8_t frec2;
	frec1 = (uint16_t)(mod_frequency / 1000);
	frec2 = (uint8_t)((mod_frequency % 1000) / 10);
	
	if (frec1<100){
		pt6311_write_digit(3, 0x000000);
		pt6311_write_int(4,frec1);//mhz
	}
	else{
		pt6311_write_int(3,frec1);//mhz
	}
	if (frec2==0){
		//shitty corrector
		pt6311_write_string(7,"00");//khz
	}
	else{
		pt6311_write_int(7,frec2);//khz
	}
	pt6311_write_digit(6, 0x80);//dec dot
}

void freq_update_visuals(uint8_t move, uint16_t khz_step){//frequency updater
	if (move) {
        if (mod_frequency <= (RF_FREQ_MAX_KHZ - khz_step)) {
            mod_frequency += khz_step;
        }
	} else {
        if (mod_frequency >= (RF_FREQ_MIN_KHZ + khz_step)) {
            mod_frequency -= khz_step;
        }
	}
		
	freq_visuals(mod_frequency);			
	RFModulator_SetFrequency(&mod, mod_frequency);
}

void frequency_screen(void)//up or down 250 khz
{
		if (!change_tracker){
			pt6311_write_string(1,"F");
			freq_visuals(mod_frequency);
			change_tracker=true;
		}
    if (button_accel_check(UP_BTN_READ(), &up_btn)) {
        freq_update_visuals(1, RF_FREQ_STEP_KHZ);
    } else if (button_accel_check(DOWN_BTN_READ(), &down_btn)) {
        freq_update_visuals(0, RF_FREQ_STEP_KHZ);
    }
}

void channel_update_visuals(uint8_t move){
		if (move){
			if (channel < 12) {
					channel++;
				} else if (channel == 12) {
						channel = 21;
        } else if (channel < 71) {
            channel++;
        }
		}
		else{
			if (channel > 21) {
							channel--;
        } else if (channel == 21) {
            channel = 12;
        } else if (channel > 1) {
            channel--;
        }
		}
		//recalculation from library used in here, avoids rfmodulator set channel function
		if (channel >= 21) {
        mod_frequency =
            CH21_FREQ_KHZ + ((uint32_t)(channel - 21) * 8000);
    } else if (channel >= 6) {
        mod_frequency =
            CH6_FREQ_KHZ + ((uint32_t)(channel - 6) * 8000);
    } else if (channel >= 3) {
        mod_frequency =
            CH3_FREQ_KHZ + ((uint32_t)(channel - 3) * 8000);
    } else {
        mod_frequency =
            CH1_FREQ_KHZ + ((uint32_t)(channel - 1) * 9500);
    }
		if (channel<10){
			pt6311_write_digit(7, 0x000000);
			pt6311_write_int(6, channel);
		}
		else{
			pt6311_write_int(6, channel);
		}
		RFModulator_SetFrequency(&mod, mod_frequency);
}
void channel_recalculate(uint32_t mod_frequency) {
		if (mod_frequency >= CH21_FREQ_KHZ && mod_frequency <= CH21_LAST_FREQ_KHZ) {
        channel = (uint8_t)(21 + ((mod_frequency - CH21_FREQ_KHZ) / 8000));
        if (channel > 71) {
            channel = 71;
        }
    }
    else if (mod_frequency >= CH6_FREQ_KHZ && mod_frequency <= CH12_FREQ_KHZ) {
        channel = (uint8_t)(6 + ((mod_frequency - CH6_FREQ_KHZ) / 8000));
        if (channel > 12) {
            channel = 12;
        }
    }
    else if (mod_frequency >= CH3_FREQ_KHZ && mod_frequency <= CH5_FREQ_KHZ) {
        channel = (uint8_t)(3 + ((mod_frequency - CH3_FREQ_KHZ) / 8000));
        if (channel > 5) {
            channel = 5;
        }
    }
    else if (mod_frequency >= CH1_FREQ_KHZ && mod_frequency <= CH2_FREQ_KHZ) {
        channel = (uint8_t)(1 + ((mod_frequency - CH1_FREQ_KHZ) / 9500));
        if (channel > 2) {
            channel = 2;
        }
    }
    else {
        channel = last_channel;//if user goes out of channel range display last valid
    }
		last_channel=channel;//save last valid channel matching exact frequency
    if (channel<10){
			pt6311_write_digit(7, 0x000000);
			pt6311_write_int(6, channel);
		}
		else{
			pt6311_write_int(6, channel);
		}
}
void channel_screen(void){
		if (!change_tracker){
				pt6311_write_string(1,"CHAN");
				channel_recalculate(mod_frequency);
				change_tracker=true;
		}
		if (button_accel_check(UP_BTN_READ(), &up_btn)){
					channel_update_visuals(1);
		} else if (button_accel_check(DOWN_BTN_READ(), &down_btn))  {
					channel_update_visuals(0);					
		} 
}

void bool_updaters(ScreenState screen){//bool updaters 
		if (screen == ps_ratio_state) {
			if (ps_ratio){
					pt6311_write_string(5,"16dB");
					RFModulator_SetPictureSoundRatio(&mod, MC44BS374T1_PS_16);
					pt6311_write_digit(0, 16384);
				}
				else{
					pt6311_write_string(5,"12dB");
					RFModulator_SetPictureSoundRatio(&mod, MC44BS374T1_PS_12);
					pt6311_write_digit(0, 0x000000);
				}
			
    } 
    else if (screen == tpen_state){
        if (tpen){
					pt6311_write_string(6,"ON ");
					RFModulator_SetTestPattern(&mod, MC44BS374T1_TPEN_ON);
					pt6311_write_digit(0, 64);
				}
				else{
					pt6311_write_string(6,"OFF");
					RFModulator_SetTestPattern(&mod, MC44BS374T1_TPEN_OFF);
					pt6311_write_digit(0, 0x000000);
				}
    } 
    else if (screen == pwc_state) {
			if (pwc){
					pt6311_write_string(6,"OFF");
					RFModulator_SetPeakWhiteClip(&mod, MC44BS374T1_PWC_OFF);
					pt6311_write_digit(0, 1024);
				}
				else{
					pt6311_write_string(6,"ON ");
					RFModulator_SetPeakWhiteClip(&mod,MC44BS374T1_PWC_ON);
					pt6311_write_digit(0, 0x000000);
				}
    }
}

void tpen_screen(void)//test pattern toggle
{
		if (!change_tracker){
			pt6311_write_string(1,"TPEN");
			bool_updaters(current_screen);
			change_tracker=true;
		}
		if (button_accel_check(UP_BTN_READ(), &up_btn)) {
					tpen = !tpen;
					bool_updaters(current_screen);
		} 
}

void pwc_screen(void)
{
		if (!change_tracker){
			pt6311_write_string(1,"PWC");
			bool_updaters(current_screen);
			change_tracker=true;
		}
		if (button_accel_check(UP_BTN_READ(), &up_btn)) {
					pwc = !pwc;
					bool_updaters(current_screen);
		} 
}

void ps_ratio_screen(void)
{
		if (!change_tracker){
			pt6311_write_string(1,"P-S");
			bool_updaters(current_screen);
			change_tracker=true;
		}
		if (button_accel_check(UP_BTN_READ(), &up_btn)) {
					ps_ratio = !ps_ratio;
					bool_updaters(current_screen);
		} 
}

void sound_screen(void)
{
    if (!change_tracker) {
        pt6311_write_string(1, "SYS");
        sound_system(sound);
        change_tracker = true;
    }

    if (button_accel_check(UP_BTN_READ(), &up_btn)) {
        if (sound >= DK_6_5MHZ) {
            sound = MN_4_5MHZ;
        } else {
            sound++;
        }
        sound_system(sound);
    }
    else if (button_accel_check(DOWN_BTN_READ(), &down_btn)) {
        if (sound == MN_4_5MHZ) {
            sound = DK_6_5MHZ;
        } else {
            sound--;
        }
        sound_system(sound);
    }
}
void sound_system(RFMod_sound_system value)
{
    if (value > DK_6_5MHZ) {
        value = MN_4_5MHZ;
    }
    sound = value;
    switch (sound) {
    case MN_4_5MHZ:
        pt6311_write_string(5, "M/N ");
        RFModulator_SetSoundSubcarrier(&mod, MC44BS374T1_SFD_45);
        break;

    case BG_5_5MHZ:
        pt6311_write_string(5, "B/G ");
        RFModulator_SetSoundSubcarrier(&mod, MC44BS374T1_SFD_55);
        break;

    case I_6_0MHZ:
        pt6311_write_string(5, "I   ");
        RFModulator_SetSoundSubcarrier(&mod, MC44BS374T1_SFD_60);
        break;

    case DK_6_5MHZ:
        pt6311_write_string(5, "D/K ");
        RFModulator_SetSoundSubcarrier(&mod, MC44BS374T1_SFD_65);
        break;
    }
}
@svlreg @far @interrupt void reset_handler(void)//skip stext
{
    //go straight to main
    main();
}