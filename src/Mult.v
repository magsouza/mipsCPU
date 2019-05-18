module Mult(Reset, Clock, w_MultStart, w_MultStop, w_MULTHI, w_MULTLO, w_A, w_B);

input Clock, Reset, w_MultStart;
input[31:0] w_A, w_B;
output reg w_MultStop;
output reg[31:0] w_MULTHI, w_MULTLO;


// Temporarios do Mult -- Algoritmo de Booth (https://en.wikipedia.org/wiki/Booth%27s_multiplication_algorithm)
//Os nomes vem da pagina do wikipedia do algoritmo
reg [64:0] A, S, P;
integer y = 32; // size of r
// A is multiplicand (m)
// B is multiplier (r)

always @(posedge Clock) begin
    if (Reset) begin // reseta tudo
        w_MULTHI = 32'b0;
        w_MULTLO = 32'b0;
        w_MultStop = 1'b0;
        A = 65'b0;
        S = 65'b0;
        P = 65'b0;
    end
    
    if(w_MultStart) begin
		
		if(y==32) begin // Setup
			A = {w_A, 33'b0};           //A: Fill the most significant (leftmost) bits with the value of m. Fill the remaining (y + 1) bits with zeros.
			S = {(~w_A + 1'b1), 33'b0}; //S: Fill the most significant bits with the value of (-m) in two's complement notation. Fill the remaining (y + 1) bits with zeros.
			P = {32'b0, w_B, 1'b0};     //P: Fill the most significant x bits with zeros. To the right of this, append the value of r. Fill the least significant (rightmost) bit with a zero.
			y = 32;
			w_MultStop = 1'b0;
		end
		
		// Now there are 4 cases, but actually two cases because two of them do nothing
		// Determine the two least significant (rightmost) bits of P.
			// If they are 01, find the value of P + A. Ignore any overflow.
			// If they are 10, find the value of P + S. Ignore any overflow.
			// If they are 00, do nothing. Use P directly in the next step.
			// If they are 11, do nothing. Use P directly in the next step.
		case(P[1:0])
		  2'b01: begin
			P = P + A;
		  end
		  2'b10: begin
			P = P + S;
		  end
		endcase
		
		// Arithmetically shift the value obtained in the 2nd step by a single place to the right. Let P now equal this new value.
		P = P >> 1;
		if (P[63] == 1'b1) begin // This will make the shift right the way it should
			P[64] = 1'b1;
		end
		
		// Repeat steps 2 and 3 until they have been done y (no nosso caso sempre 32) times.
		y = y - 1;
		if (y==0) begin
		  w_MULTHI = P[64:33];
		  w_MULTLO = P[32:1];
		  w_MultStop = 1'b1;
		  y = -1;
		end
		if ( y == -1) begin
		  A = 65'b0;
		  S = 65'b0;
		  P = 65'b0; 
		end
	  end
end
endmodule