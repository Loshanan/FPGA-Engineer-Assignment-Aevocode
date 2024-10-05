class PIDController {
private:
    float kp, ki, kd;
    float prev_error, integral;
    float dt;

public:
    PIDController (float kp_, float ki_, float kd_, float dt_)
        : kp(kp_), ki(ki_), kd(kd_), dt(dt_), prev_error(0), integral(0) {}

    float compute(float setpoint, float actual_speed) {
        float error = setpoint - actual_speed;
        integral += error * dt;
        float derivative = (error - prev_error) / dt;
        prev_error = error;

        return kp * error + ki * integral + kd * derivative;
    }
};