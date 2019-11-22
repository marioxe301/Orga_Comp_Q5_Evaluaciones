module MemEncoder(
    input [10:0]physicalAddr,
    output reg [31:0] virtualAddr,
    output reg isStack
);
    wire [31:0] physicalAddr32_P,physicalAddr32;

    assign physicalAddr32 = {20'b0,physicalAddr};

    always @(*) begin
        if(physicalAddr32 >= 0  && physicalAddr32<= 4095)begin
            isStack = 1'b0;
            virtualAddr = 32'h10010000 + physicalAddr32;
        end else if( physicalAddr32>= 4095 && physicalAddr32<= 8192 ) begin
            isStack = 1'b1;
            virtualAddr = 32'h7FFFEFFC + physicalAddr32;
        end
    end

endmodule 