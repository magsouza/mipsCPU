module MaquinaEstados(Clock, w_opcode, w_funct, Estado);

initial Estado <= 7'b0000001;

always @(posedge Clock)
    begin
        case (Estado)
            7'b0000001 : Estado <= 7'b0000010;
            7'b0000010 : Estado <= 7'b0000011;
            7'b0000011 : Estado <= 7'b0000010;
    end
endmodule
