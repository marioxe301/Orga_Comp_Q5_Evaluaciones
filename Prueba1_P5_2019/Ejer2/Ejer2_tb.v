module Ejer2_tb;

  reg isZero;
  reg isBEQ;
  reg isBNE;
  reg isJmp;
  reg [31:0] currentPC;
  reg [31:0] jmpTarget32;
  reg [31:0] branchTargetAddr;
  wire [31:0] nextPC;

    Ejer2 ej2 (
        .isZero( isZero ),
        .isBEQ( isBEQ ),
        .isBNE( isBNE ),
        .isJmp( isJmp ),
        .currentPC( currentPC ),
        .jmpTarget32( jmpTarget32 ),
        .branchTargetAddr( branchTargetAddr ),
        .nextPC( nextPC )
    );

    reg [131:0] patterns[0:5];
    integer i;

    initial begin
        patterns[0] = {1'bx, 1'b0, 1'b0, 1'b1, 32'haabbcc00, 32'haabbccdd, 32'hdeadbeef, 32'haabbccdd};
        patterns[1] = {1'b0, 1'b1, 1'b0, 1'bx, 32'haabbcc00, 32'haabbccdd, 32'hdeadbeef, 32'haabbcc04};
        patterns[2] = {1'b1, 1'b1, 1'b0, 1'bx, 32'haabbcc00, 32'haabbccdd, 32'hdeadbeef, 32'hdeadbeef};
        patterns[3] = {1'b1, 1'b0, 1'b1, 1'bx, 32'haabbcc00, 32'haabbccdd, 32'hdeadbeef, 32'haabbcc04};
        patterns[4] = {1'b0, 1'b0, 1'b1, 1'bx, 32'haabbcc00, 32'haabbccdd, 32'hdeadbeef, 32'hdeadbeef};
        patterns[5] = {1'bx, 1'bx, 1'bx, 1'bx, 32'haabbcc00, 32'haabbccdd, 32'hdeadbeef, 32'haabbcc04};
        for (i = 0; i < 6; i = i + 1)
        begin
            isZero = patterns[i][131];
            isBEQ = patterns[i][130];
            isBNE = patterns[i][129];
            isJmp = patterns[i][128];
            currentPC = patterns[i][127:96];
            jmpTarget32 = patterns[i][95:64];
            branchTargetAddr = patterns[i][63:32];
            $display("%b %b %b %b", isZero, isBEQ, isBNE, isJmp);
            #10;
            if (nextPC !== patterns[i][31:0])
            begin
                $display("nextPC: (assertion error) %h %h %d", patterns[i][31:0], nextPC, i);
                $finish;
            end
        end

        $display("All tests passed.");
    end
endmodule