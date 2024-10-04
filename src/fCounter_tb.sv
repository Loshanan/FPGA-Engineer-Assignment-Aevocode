`timescale 1ns/1ps
module fCounter_tb ();

    parameter CLK_PERIOD = 100;     // (100ns) 10MHz
    parameter PPR = 10;             // ppr of the motor encoder
    parameter REG_UPDATE_FREQ = 10;   // speed register update frequency

    logic clk;
    logic rst;
    logic data;
    logic [31:0] rpm;

    fCounter #(
        .CLK_PERIOD(CLK_PERIOD),
        .PPR(PPR),
        .REG_UPDATE_FREQ(REG_UPDATE_FREQ)
    ) dut (
        .clk(clk),
        .data(data),
        .rpm(rpm)
    );

    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk <= ~clk;
    end

    initial begin
        rst = 0;
        data = 0;
        @(posedge clk)
        #200
        rst = 1;
        repeat(5) begin // expected rpm = 1000
            data = 1;
            #6_000_000;
            data = 0;
            #6_000_000;
        end
        $finish;
    end

endmodule