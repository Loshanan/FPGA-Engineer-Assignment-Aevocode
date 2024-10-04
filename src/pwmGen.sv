module pwmGen #(
    parameter CLK_PERIOD;     
    parameter DATA_WIDTH,
) (
    input clk,
    input logic [DATA_WIDTH - 1:0] pwmPeriod,   // in micro s
    input logic [DATA_WIDTH - 1:0] pwmDutyCycle,// in micro s
    output logic pwm
);

    localparam pwmPeriod_ns = pwmPeriod * 1000;         // in ns
    localparam pwmDutyCycle_ns = pwmDutyCycle * 1000;   // in ns
    
    assign pwm = '0;
    logic [DATA_WIDTH - 1:0] counter;

    assign counter = '0;

    always_ff @( posedge clk ) begin
        if (counter < pwmPeriod_ns ) counter <= counter + CLK_PERIOD;
        else counter <= 0;
    end

    always_ff @( posedge ) begin
        if (counter < pwmDutyCycle_ns) pwm <= 1;
        else pwm <= 0;
    end

    
endmodule