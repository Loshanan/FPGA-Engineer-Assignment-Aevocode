#include "accessRegister.h"
#include "PIDController.h"

int main() {
    PIDController pid(0.1, 0.01, 0.05, 0.1);

    int targetSpeed = 5000;
    int currentSpeed = 0;

    int pwmPeriod = 100;  // in micro s
    setPWMPeriod(pwmPeriod);

    while (true) {
        currentSpeed = readSpeedRegister;

        float dutyCycle = pid.compute(targetSpeed, currentSpeed);

        int dutyCycle_us = (int)(pwmPeriod * (dutyCycle / 100.));

        dutyCycle_us = (dutyCycle_us < 0) ? 0 : (dutyCycle_us > pwmPeriod) ? pwmPeriod : dutyCycle_us;

        setPWMDutyCycle(dutyCycle_us);

        sleep(0.1);
    }
    
}