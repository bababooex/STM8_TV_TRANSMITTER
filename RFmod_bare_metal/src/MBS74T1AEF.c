#include "MBS74T1AEF.h"

//raw i2c bit write to toggle single data
void bitWrite(uint8_t* byte, uint8_t bit, uint8_t value) {
    if (value) {
        *byte |= (1 << bit);
    } else {
        *byte &= ~(1 << bit);
    }
}

void RFModulator_Init(RFModulator* mod, uint8_t address) {
    mod->i2c_address = address;
    mod->rf_test = MC44BS374T1_WM2_NORMAL;
    mod->rf_divider = MC44BS374T1_WM1_NORMAL;
    mod->rf_so = MC44BS374T1_SO_ON;
    mod->rf_lop = MC44BS374T1_LOP_HIGH;
    mod->rf_ps = MC44BS374T1_PS_12;
    mod->rf_pwc = MC44BS374T1_PWC_ON;
    mod->rf_osc = MC44BS374T1_OSC_NORMAL;
    mod->rf_att = MC44BS374T1_ATT_NORMAL;
    mod->rf_sfd = MC44BS374T1_SFD_65;
    mod->rf_tpen = MC44BS374T1_TPEN_OFF;
    mod->rf_value = 0;
}

void RFModulator_SendDataRaw(RFModulator* mod, uint8_t c1, uint8_t c0, uint8_t fm, uint8_t fl) {
    uint8_t data[4];
    data[0] = c1;
    data[1] = c0;
    data[2] = fm;
    data[3] = fl;
    swi2c_write_array(mod->i2c_address, data, 4);
}

uint8_t RFModulator_RegisterC1(uint8_t so, uint8_t lop, uint8_t ps, uint8_t wm2, uint8_t wm1) {
    uint8_t output = 0x80;
    bitWrite(&output, 5, so);
    bitWrite(&output, 4, lop);
    bitWrite(&output, 3, ps);
    bitWrite(&output, 2, (wm2 & 0x01));
    bitWrite(&output, 1, (wm1 & 0x04) >> 2);
    bitWrite(&output, 0, 0);
    return output;
}

uint8_t RFModulator_RegisterC0(uint8_t pwc, uint8_t osc, uint8_t att, uint8_t sfd, uint8_t wm2) {
    uint8_t output = 0x00;
    bitWrite(&output, 7, pwc);
    bitWrite(&output, 6, osc);
    bitWrite(&output, 5, att);
    bitWrite(&output, 4, (sfd & 0x02) >> 1);
    bitWrite(&output, 3, (sfd & 0x01));
    bitWrite(&output, 2, 0);
    bitWrite(&output, 1, (wm2 & 0x04) >> 2);
    bitWrite(&output, 0, (wm2 & 0x02) >> 1);
    return output;
}

uint8_t RFModulator_RegisterFM(uint8_t tpen, uint16_t divider) {
    uint8_t output = 0x00;
    bitWrite(&output, 6, tpen);
    bitWrite(&output, 5, (divider & 0x800) >> 11);
    bitWrite(&output, 4, (divider & 0x400) >> 10);
    bitWrite(&output, 3, (divider & 0x200) >> 9);
    bitWrite(&output, 2, (divider & 0x100) >> 8);
    bitWrite(&output, 1, (divider & 0x080) >> 7);
    bitWrite(&output, 0, (divider & 0x040) >> 6);
    return output;
}

uint8_t RFModulator_RegisterFL(uint16_t divider, uint8_t wm1) {
    uint8_t output = 0x00;
    bitWrite(&output, 7, (divider & 0x020) >> 5);
    bitWrite(&output, 6, (divider & 0x010) >> 4);
    bitWrite(&output, 5, (divider & 0x008) >> 3);
    bitWrite(&output, 4, (divider & 0x004) >> 2);
    bitWrite(&output, 3, (divider & 0x002) >> 1);
    bitWrite(&output, 2, (divider & 0x001));
    bitWrite(&output, 1, (wm1 & 0x02) >> 1);
    bitWrite(&output, 0, (wm1 & 0x01));
    return output;
}

void RFModulator_SetFrequency(RFModulator* mod, uint32_t freq) {
    uint8_t rfdivider = 1;
    uint32_t freqdiv;
    if((freq <= MC44BS374T1_UHF_MAX) && (freq > MC44BS374T1_UHF_MIN)) {
        rfdivider = 1;
        mod->rf_divider = MC44BS374T1_WM1_NORMAL;
    }
    else if((freq <= MC44BS374T1_VHF_MAX) && (freq > 230000)) {
        rfdivider = 2;
        mod->rf_divider = MC44BS374T1_WM1_RF2;
    }
    else if((freq <= 230000) && (freq > 115000)) {
        rfdivider = 4;
        mod->rf_divider = MC44BS374T1_WM1_RF4;
    }
    else if((freq <= 115000) && (freq > 57500)) {
        rfdivider = 8;
        mod->rf_divider = MC44BS374T1_WM1_RF8;
    }
    else if((freq <= 57500) && (freq > MC44BS374T1_VHF_MIN)) {
        rfdivider = 16;
        mod->rf_divider = MC44BS374T1_WM1_RF16;
    }
    else {
        rfdivider = 1;
        mod->rf_divider = MC44BS374T1_WM1_NORMAL;
        freq = 871250;
    }
    
    freqdiv = freq / 10;
    freqdiv *= 4 * rfdivider;
    mod->rf_value = (uint16_t)(freqdiv / 100);
    
    RFModulator_SendRegister(mod);
}

void RFModulator_SetPictureSoundRatio(RFModulator* mod, uint8_t val) {
    mod->rf_ps = val;
    RFModulator_SendRegister(mod);
}

void RFModulator_SetSoundSubcarrier(RFModulator* mod, uint8_t val) {
    mod->rf_sfd = val;
    RFModulator_SendRegister(mod);
}
/*
void RFModulator_SetChannel(RFModulator* mod, uint8_t channel) {
    if((channel <= 71) && (channel >= 21)) {
        RFModulator_SetFrequency(mod, MC44BS374T1_CH_4 + (channel - 21) * 8);
    }
    else if((channel <= 12) && (channel >= 6)) {
        RFModulator_SetFrequency(mod, MC44BS374T1_CH_3 + (channel - 6) * 8);
    }
    else if((channel <= 5) && (channel >= 3)) {
        RFModulator_SetFrequency(mod, MC44BS374T1_CH_2 + (channel - 3) * 8);
    }
    else if((channel <= 2) && (channel >= 1)) {
        RFModulator_SetFrequency(mod, MC44BS374T1_CH_1 + (uint32_t)((channel - 1) * 9.5));
    }
}
*/
void RFModulator_SetSoundOscillator(RFModulator* mod, uint8_t state) {
    mod->rf_so = state;
    RFModulator_SendRegister(mod);
}

void RFModulator_SetLogicOutputPort(RFModulator* mod, uint8_t state) {
    mod->rf_lop = state;
    RFModulator_SendRegister(mod);
}

void RFModulator_SetPeakWhiteClip(RFModulator* mod, uint8_t state) {
    mod->rf_pwc = state;
    RFModulator_SendRegister(mod);
}

void RFModulator_SetOscillator(RFModulator* mod, uint8_t state) {
    mod->rf_osc = state;
    RFModulator_SendRegister(mod);
}

void RFModulator_SetAttenuation(RFModulator* mod, uint8_t state) {
    mod->rf_att = state;
    RFModulator_SendRegister(mod);
}

void RFModulator_SetTestPattern(RFModulator* mod, uint8_t state) {
    mod->rf_tpen = state;
    RFModulator_SendRegister(mod);
}

void RFModulator_SetTestMode(RFModulator* mod, uint8_t state) {
    mod->rf_test = state;
    RFModulator_SendRegister(mod);
}

uint8_t RFModulator_GetStatus(RFModulator* mod) {
    uint8_t data[1] = {0};
    uint8_t result = swi2c_read_array(mod->i2c_address, data, 1);
    if(result == 0) {
        return data[0];
    }
    return 0xFF;
}

void RFModulator_SendRegister(RFModulator* mod) {
    uint8_t c0 = RFModulator_RegisterC0(mod->rf_pwc, mod->rf_osc, mod->rf_att, mod->rf_sfd, mod->rf_test);
    uint8_t c1 = RFModulator_RegisterC1(mod->rf_so, mod->rf_lop, mod->rf_ps, mod->rf_test, mod->rf_divider);
    uint8_t fm = RFModulator_RegisterFM(mod->rf_tpen, mod->rf_value);
    uint8_t fl = RFModulator_RegisterFL(mod->rf_value, mod->rf_divider);
    
    RFModulator_SendDataRaw(mod, c1, c0, fm, fl);
}