module axiSlave #(
    parameter DATA_WIDTH,
    parameter ADDR_WIDTH
) (
    input logic clk,

    input logic [ADDR_WIDTH - 1:0] writeAddress,
    input logic [DATA_WIDTH - 1:0] writeData,
    output logic writeResponse,

    input logic [ADDR_WIDTH - 1:0] readAddress,
    output logic [DATA_WIDTH - 1:0] readData,

    input logic [DATA_WIDTH - 1:0] reg1,
    output logic [DATA_WIDTH - 1:0] reg2,
    output logic [DATA_WIDTH - 1:0] reg3
);

    // writing block
    always_ff @( posedge clk ) begin
        if (writeAddress == 2'b10) begin
            reg2 <= writeData;
            writeResponse <= 1'b1;
        end        
        else if (writeAddress == 2'b11) begin
            reg3 <= writeData;
            writeResponse <= 1'b1;
        end
        else writeResponse <= 1'b0;
    end

    //reading block
    always_ff @( posedge clk ) begin
        if (readAddress == 2'b01) readData <= reg1;
        else readData <= '0;
    end

endmodule