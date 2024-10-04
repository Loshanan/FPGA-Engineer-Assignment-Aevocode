module main #(
    parameter CLK_PERIOD = 100, // (100ns) 10MHz
    parameter PPR = 10,         // ppr of the motor encoder
    parameter DATA_WIDTH = 32,  // width of the 3 registers
    parameter ADDR_WIDTH = 2    // for those 3 registers
    parameter REG_UPDATE_FREQ = 10   // speed register update frequency
) (
    input logic clk,

    input logic [ADDR_WIDTH - 1:0] writeAddress,
    input logic [DATA_WIDTH - 1:0] writeData,
    output logic writeResponse,

    input logic [ADDR_WIDTH - 1:0] readAddress,
    output logic [DATA_WIDTH - 1:0] readData,

    input logic pulseData,

    output logic PWM
);
    
    logic [31:0] reg1;
    logic [31:0] reg2;
    logic [31:0] reg3;
    
    axiSlave #(DATA_WIDTH, ADDR_WIDTH) slave(clk, writeAddress, writeData, writeResponse, readAddress, readData, reg1, reg2, reg3);
    
    pwmGen #(CLK_PERIOD, DATA_WIDTH) pwmgen(clk, reg2, reg3, PWM);

    fCounter #(CLK_PERIOD, PPR, REG_UPDATE_FREQ) rpmcounter(clk, pulseData, reg1);

endmodule