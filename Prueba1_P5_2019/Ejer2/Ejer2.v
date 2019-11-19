module Ejer2(
  input isZero,
  input isBEQ,
  input isBNE,
  input isJmp,
  input [31:0] currentPC,
  input [31:0] jmpTarget32,
  input [31:0] branchTargetAddr,
  output reg [31:0] nextPC
);

// Calcule el valor del nextPC
always @(*) begin
  if(isJmp)begin
      nextPC = jmpTarget32;
  end else if(isBEQ && isZero)begin
      nextPC = branchTargetAddr;
  end else if(isBNE && !isZero)begin
      nextPC = branchTargetAddr;
  end else begin
      nextPC = currentPC + 4;
  end
end

endmodule
