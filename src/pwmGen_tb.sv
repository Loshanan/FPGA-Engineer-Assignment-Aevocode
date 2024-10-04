`timescale 1ns/1ps
module pwmGen_tb ();

    parameter CLK_PERIOD = 100;
    parameter DATA_WIDTH = 32;

    logic clk;
    logic rst;
    logic [DATA_WIDTH - 1:0] pwmPeriod;
    logic [DATA_WIDTH - 1:0] pwmDutyCycle;
    logic pwm;

    pwmGen #(
        .CLK_PERIOD(CLK_PERIOD),
        .DATA_WIDTH(DATA_WIDTH)
        ) dut (
            .clk(clk),
            .rst(rst),
            .pwmPeriod(pwmPeriod),
            .pwmDutyCycle(pwmDutyCycle),
            .pwm(pwm)
        );

    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk <= ~clk;
    end

    initial begin
        rst = 0;
        pwmPeriod = 32'd2;
        pwmDutyCycle = 32'd1;
        @(posedge clk)
        #200
        rst = 1;
        #5000
        rst = 0;
        pwmPeriod = 32'd4;
        pwmDutyCycle = 32'd1;
        @(posedge clk)
        #200
        rst = 1;
        #5000
        $finish;
    end
    
endmodule