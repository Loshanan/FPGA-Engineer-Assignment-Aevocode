module main #(
    parameter CLK_PERIOD = 10_000_000,
    parameter PPR = 10,
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 2
) (
    input logic clk,

    input logic [ADDR_WIDTH - 1:0] writeAddress,
    input logic [DATA_WIDTH - 1:0] writeData,
    output logic writeResponse,

    input logic [ADDR_WIDTH - 1:0] readAddress,
    output logic [DATA_WIDTH - 1:0] readData
);
    
    logic [31:0] reg1;
    logic [31:0] reg2;
    logic [31:0] reg3;
    
    axiSlave slave(clk, writeAddress, writeData, writeResponse, readAddress, readData, reg1, reg2, reg3);


endmodule