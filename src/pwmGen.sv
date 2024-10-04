module pwmGen #(
    parameter CLK_PERIOD,     
    parameter DATA_WIDTH
) (
    input clk,
    input logic [DATA_WIDTH - 1:0] pwmPeriod,   // in micro s
    input logic [DATA_WIDTH - 1:0] pwmDutyCycle,// in micro s
    output logic pwm
);

    // localparam pwmPeriod_ns = pwmPeriod * 1000;         // in ns
    // localparam pwmDutyCycle_ns = pwmDutyCycle * 1000;   // in ns

    logic [DATA_WIDTH - 1:0] pwmPeriod_ns;
    logic [DATA_WIDTH - 1:0] pwmDutyCycle_ns;
    
    logic [DATA_WIDTH - 1:0] counter;

    always_comb begin
        pwmPeriod_ns = (pwmPeriod * 1000) / CLK_PERIOD;
        pwmDutyCycle_ns = (pwmDutyCycle * 1000) / CLK_PERIOD;
    end

    initial begin
        counter = '0;
        pwm = '0;
    end

    always_ff @( posedge clk ) begin
        if (counter < pwmPeriod_ns ) counter <= counter + 1;
        else counter <= 0;
    end

    always_ff @( posedge clk ) begin
        if (counter < pwmDutyCycle_ns) pwm <= 1;
        else pwm <= 0;
    end

    
endmodule