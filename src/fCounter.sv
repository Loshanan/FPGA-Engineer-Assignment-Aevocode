module fCounter #(
    parameter CLK_PERIOD = 100 , // (100ns) 10MHz
    parameter PPR = 10,         // ppr of the motor encoder
    parameter REG_UPDATE_FREQ = 10   // speed register update frequency
) (
    input clk,
    input data,
    output [31:0] rpm
);

    localparam UPDATE_PERIOD = (1_000_000_000 / REG_UPDATE_FREQ) / CLK_PERIOD;     // update period 100ms
    localparam CONST = (60 * REG_UPDATE_FREQ) / PPR;                  // rpm = CONST * data_pulse_count    

    logic [31:0] clkCounter;
    logic [31:0] dataCounter;
    logic [31:0] rpmReg;
   

    always_ff @( posedge data ) begin
        dataCounter <= dataCounter + 1;
    end

    always_ff @( posedge clk ) begin
        if (clkCounter >= UPDATE_PERIOD) begin
            rpmReg <= CONST * dataCounter;
            dataCounter <= 0;
            clkCounter <= 0;
        end
        else clkCounter <= clkCounter + 1;
    end
    
    assign rpm = rpmReg;
endmodule