int readSpeedRegister() {
    volatile int* reg1 = (int*)0x40000000;  // change address here
    return *reg1;
}

void setPWMDutyCycle(int dutyCycle) {
    volatile int* reg2 = (int*)0x40000004;  // change address here
    *reg2 = dutyCycle;
}

void setPWMPeriod(int period) {
    volatile int* reg3 = (int*)0x40000008;  // change address here
    *reg3 = period;
}