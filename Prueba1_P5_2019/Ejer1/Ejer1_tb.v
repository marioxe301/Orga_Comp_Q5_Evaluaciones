module Ejer1_tb;
    reg [5:0] opc;
    reg [5:0] func;
    wire isJmp;
    wire isBeq;
    wire isBne;
    wire [1:0] rfWriteDataSel;
    wire rfWriteAddrSel;
    wire rfWriteEnable;
    wire memWrite;
    wire memRead;
    wire aluSrc;
    wire [2:0] aluFunc;
    wire bitXtend;
    wire invOpcode;

    Ejer1 ej1 (
        .opc (opc),
        .func (func),
        .isJmp (isJmp),
        .isBeq (isBeq),
        .isBne (isBne),
        .rfWriteDataSel (rfWriteDataSel),
        .rfWriteAddrSel (rfWriteAddrSel),
        .rfWriteEnable (rfWriteEnable),
        .memWrite (memWrite),
        .memRead (memRead),
        .aluSrc (aluSrc),
        .aluFunc (aluFunc),
        .bitXtend (bitXtend),
        .invOpcode (invOpcode) 
    );

    reg [26:0] patterns[0:4];
    integer i;

    initial begin
      patterns[0] = {6'b0     , `MIPS_AND, 1'b0, 1'b0, 1'b0, 2'b00, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, `ALU_AND, 1'bx, 1'b0};
      patterns[1] = {`MIPS_LW , 6'b0     , 1'b0, 1'b0, 1'b0, 2'b01, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1, `ALU_ADD, 1'b0, 1'b0};
      patterns[2] = {`MIPS_BNE, 6'b0     , 1'b0, 1'b0, 1'b1, 2'bxx, 1'bx, 1'b0, 1'b0, 1'b0, 1'bx, `ALU_SUB, 1'bx, 1'b0};
      patterns[3] = {6'h2a    , 6'b0     , 1'b0, 1'b0, 1'b0, 2'bxx, 1'bx, 1'b0, 1'b0, 1'b0, 1'bx, `ALU_UNDEF, 1'bx, 1'b1};
      patterns[4] = {6'b0     , 6'h2f    , 1'b0, 1'b0, 1'b0, 2'bxx, 1'bx, 1'b0, 1'b0, 1'b0, 1'bx, `ALU_UNDEF, 1'bx, 1'b1};

      for (i = 0; i < 5; i = i + 1)
      begin
        opc = patterns[i][26:21];
        func = patterns[i][20:15];
        #10;
        if (isJmp !== patterns[i][14])
        begin
            $display("isJmp: (assertion error)", i);
            $finish;
        end
        if (isBeq !== patterns[i][13])
        begin
            $display("isBeq: (assertion error)");
            $finish;
        end
        if (isBne !== patterns[i][12])
        begin
            $display("isBne: (assertion error)");
            $finish;
        end
        if (rfWriteDataSel !== patterns[i][11:10])
        begin
            $display("rfWriteDataSel: (assertion error) %h %h %d", patterns[i][11:10], rfWriteDataSel, i);
            $finish;
        end
        if (rfWriteAddrSel !== patterns[i][9])
        begin
            $display("rfWriteAddrSel: (assertion error) %h %h %d", rfWriteAddrSel, patterns[i][9], i);
            $finish;
        end
        if (rfWriteEnable !== patterns[i][8])
        begin
            $display("rfWriteEnable: (assertion error)");
            $finish;
        end
        if (memWrite !== patterns[i][7])
        begin
            $display("memWrite: (assertion error)");
            $finish;
        end
        if (memRead !== patterns[i][6])
        begin
            $display("memRead: (assertion error)");
            $finish;
        end
        if (aluSrc !== patterns[i][5])
        begin
            $display("aluSrc: (assertion error)");
            $finish;
        end
        if (aluFunc !== patterns[i][4:2])
        begin
            $display("aluFunc: (assertion error) %h %h %d", patterns[i][4:2], aluFunc, i);
            $finish;
        end
        if (bitXtend !== patterns[i][1])
        begin
            $display("bitXtend: (assertion error) %h %h %d", patterns[i][1], bitXtend, i);
            $finish;
        end
        if (invOpcode !== patterns[i][0])
        begin
            $display("%d:out: (assertion error)");
            $finish;
        end
      end

      $display("All tests passed.");
    end
endmodule