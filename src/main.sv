module main #(
    parameter CLK_PERIOD = 100, // (100ns) 10MHz
    parameter PPR = 10,         // ppr of the motor encoder
    parameter DATA_WIDTH = 32,  // width of the 3 registers
    parameter ADDR_WIDTH = 2,   // for those 3 registers
    parameter REG_UPDATE_FREQ = 10   // speed register update frequency
) (
    input logic clk, rst,

    // axi write signals
    input logic awvalid,        // write address valid
    output logic awready,       // slave ready to accept write adress
    input logic [ADDR_WIDTH - 1:0] awaddr, //write address
    input logic [DATA_WIDTH - 1:0] wdata, //write data
    input logic wvalid,         // write data valid
    output logic wready,        // slave ready to accept data
    output logic wresp,         // write response

    // axi read signal
    input logic arvalid,        // valid read address presents
    output logic arready,       // slave ready to accept read address
    input logic [ADDR_WIDTH - 1:0] araddr, //read address
    output logic [DATA_WIDTH - 1:0] rData, // read data
    output logic rvalid,        // valid read response is present

    // encoder pulse output from the motor
    input logic pulseData,

    // desired pwm output
    output logic PWM
);
    
    logic [31:0] reg1;
    logic [31:0] reg2;
    logic [31:0] reg3;
    
    axiSlave #(DATA_WIDTH, ADDR_WIDTH) axislave(.*);
    
    pwmGen #(CLK_PERIOD, DATA_WIDTH) pwmgen(clk, rst, reg2, reg3, PWM);

    fCounter #(CLK_PERIOD, PPR, REG_UPDATE_FREQ) rpmcounter(clk, rst, pulseData, reg1);

endmodule