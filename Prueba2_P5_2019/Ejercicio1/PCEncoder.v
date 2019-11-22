module PCEncoder(
    input [9:0] physicalAddr,
    output [31:0] virtualAddr
);
    wire [31:0] physicalAddr32;

    assign physicalAddr32 = {22'b0,physicalAddr} ;
    assign virtualAddr = 32'h00400000 + physicalAddr32;


endmodule