module Div(Reset, Clock, w_DivStart, w_DivStop, w_DIVHI, w_DIVLO, w_A, w_B, w_DivZero);


input Clock, Reset, w_DivStart;
input[31:0] w_A, w_B;
output reg w_DivStop, w_DivZero;
output reg[31:0] w_DIVHI, w_DIVLO;


// Usando algoritmo do Wikipedia de divisão, faz A/B.
/*
will divide N(A) by D(B), placing the quotient in Q and the remainder in R.
if D = 0 then error(DivisionByZeroException) end
Q := 0                  -- Initialize quotient and remainder to zero
R := 0                     
for i := n − 1 .. 0 do  -- Where n is number of bits in N
  R := R << 1           -- Left-shift R by 1 bit
  R(0) := N(i)          -- Set the least-significant bit of R equal to bit i of the numerator
  if R ≥ D then
    R := R − D
    Q(i) := 1
  end
end
*/
// Esse algoritmo é sem sinal, então eu vou tirar o sinal dos numeros e depois eu coloco usando a seguinte formula:
/*
+ div + Quo = + Rem = +
- div + Quo = - Rem = -
+ div - Quo = - Rem = +
- div - Quo = + Rem = -
*/
reg [30:0] Q, R;
integer i = 31;
reg [30:0] N, D;

always @(posedge Clock) begin
  
  if(Reset) begin // Reseta tudo
      w_DIVHI = 32'b0;
      w_DIVLO = 32'b0;
      w_DivStop = 1'b0;
      Q = 31'b0;
      R = 31'b0;
      N = 31'b0;
      D = 31'b0;
  end
  
  if(w_DivStart) begin // Setup
      N = w_A[30:0];
      D = w_B[30:0];
      Q = 31'b0;
      R = 31'b0;
      i = 31;
      w_DivStop = 1'b0;
  end
  
  if(D == 0) begin // Excecao
    w_DivZero = 1'b1;
  end
  
  R = R << 1;
  R[0] = N[i-1];
  
  if( R >= D) begin
    R = R - D;
    Q[i-1] = 1'b1;
  end
  i = i - 1;
  
  if(i==0) begin // Cabo
    //Lidando com o sinal que eu tirei no começo
    case({w_A[31], w_B[31]})
        2'b00: begin // + div + Quo = + Rem = +
            w_DIVHI = {1'b0, R};
            w_DIVLO = {1'b0, Q};
        end
        
        2'b01: begin // + div - Quo = - Rem = +
            w_DIVHI = {1'b0, R};
            w_DIVLO = {1'b1, Q};
        end
        2'b10: begin // - div + Quo = - Rem = -
            w_DIVHI = {1'b1, R};
            w_DIVLO = {1'b1, Q};
        end
        2'b11: begin // - div - Quo = + Rem = -
            w_DIVHI = {1'b1, R};
            w_DIVLO = {1'b0, Q};
        end
    endcase
    w_DivStop = 1'b1;
    Q = 31'b0;
    R = 31'b0;
    N = 31'b0;
    D = 31'b0;
    
  end
end
endmodule
