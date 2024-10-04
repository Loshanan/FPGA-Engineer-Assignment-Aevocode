module pwmGen #(
    parameter CLK_PERIOD = 100 , // (100ns) 10MHz     
    parameter DATA_WIDTH = 32  // width of the 3 registers
) (
    input clk, rst,
    input logic [DATA_WIDTH - 1:0] pwmPeriod,   // in micro s
    input logic [DATA_WIDTH - 1:0] pwmDutyCycle,// in micro s
    output logic pwm
);

    logic [DATA_WIDTH - 1:0] pwmPeriod_cycles;
    logic [DATA_WIDTH - 1:0] pwmDutyCycle_cycles;
    logic [DATA_WIDTH - 1:0] counter;

    always_comb begin
        pwmPeriod_cycles = (pwmPeriod * 1000) / CLK_PERIOD;
        pwmDutyCycle_cycles = (pwmDutyCycle * 1000) / CLK_PERIOD;
    end

    always_ff @( posedge clk or negedge rst ) begin
        if (!rst) begin
            counter <= 1;
            pwm <= 0;
        end
        else begin
            if (counter < pwmPeriod_cycles ) counter <= counter + 1;
            else counter <= 1;
            if (counter <= pwmDutyCycle_cycles) pwm <= 1;
            else pwm <= 0;    
        end
    end

    
endmodule