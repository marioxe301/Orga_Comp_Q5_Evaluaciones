`include "mips32_opcodes.vh"
`include "alu_defines.vh"

module Ejer1(
    input [5:0] opc, //! Opcode
    input [5:0] func, //! Function
    output reg  isJmp, //! Jump signal
    output reg  isBeq, //! BEQ signal
    output reg  isBne, //! BNE signal
    output reg  [1:0] rfWriteDataSel, //! Register File Write Data Select
    output reg  rfWriteAddrSel, //! Register File Write Address Select
    output reg  rfWriteEnable, //! Register Write Enable
    output reg  memWrite, //! Memory Write
    output reg  memRead, //! Memory Read
    output reg  aluSrc, //! ALU source
    output reg  [2:0] aluFunc, //! ALU operation
    output reg  bitXtend, //! Bit extension, 0 = sign extend, 1 = zero extend
    output reg  invOpcode //! Invalid opcode or function
);

// Implemente la unidad de control para las operaciones 
// AND, LW, BNE
    always @(*) begin
        if(opc== 6'b0)begin
            case(func)
                `MIPS_AND:begin
                    rfWriteAddrSel = 1'b1;
                    rfWriteEnable = 1'b1;
                    aluFunc = `ALU_AND;
                    rfWriteDataSel = 2'b0;
                    aluSrc = 1'b0;
                    
                    bitXtend = 1'bx;
                    memRead = 1'b0;
                    memWrite = 1'b0;

                    invOpcode = 1'b0;
                    isJmp = 1'b0;
                    isBeq = 1'b0;
                    isBne = 1'b0;

                end
                default:begin
                    invOpcode = 1'b1;

                    rfWriteAddrSel = 1'bx;
                    rfWriteEnable = 1'b0;
                    aluFunc = 3'bx;
                    rfWriteDataSel = 2'bx;
                    aluSrc = 1'bx;
                    
                    bitXtend = 1'bx;
                    memRead = 1'b0;
                    memWrite = 1'b0;
                
                    isJmp = 1'b0;
                    isBeq = 1'b0;
                    isBne = 1'b0;
                end
            endcase
        end else begin
            case (opc)
                `MIPS_LW:begin
                    memRead = 1'b1;
                    rfWriteDataSel = 2'b1;
                    aluSrc = 1'b1;
                    rfWriteAddrSel = 1'b0;
                    aluFunc = `ALU_ADD;
                    bitXtend = 1'b0;
                    rfWriteEnable = 1'b1;

                    memWrite = 1'b0;

                    invOpcode = 1'b0;
                    isJmp = 1'b0;
                    isBeq = 1'b0;
                    isBne = 1'b0;
                    
                end
                `MIPS_BNE:begin
                    isBne = 1'b1;
                    aluFunc = `ALU_SUB;

                    aluSrc = 1'bx;
                    rfWriteAddrSel = 1'bx;
                    rfWriteDataSel = 2'bx;
                    bitXtend = 1'bx;

                    rfWriteEnable = 1'b0;

                    memRead = 1'b0;
                    memWrite = 1'b0;

                    isJmp = 1'b0;
                    isBeq = 1'b0;
                    invOpcode = 1'b0;
                    
                end

                default:begin
                    invOpcode = 1'b1;

                    rfWriteAddrSel = 1'bx;
                    rfWriteEnable = 1'b0;
                    aluFunc = 3'bx;
                    rfWriteDataSel = 2'bx;
                    aluSrc = 1'bx;
                    
                    bitXtend = 1'bx;
                    memRead = 1'b0;
                    memWrite = 1'b0;
                
                    isJmp = 1'b0;
                    isBeq = 1'b0;
                    isBne = 1'b0;
                end
            endcase
        end
    end

endmodule
