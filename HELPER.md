# Doc Helper

### Padrão nome dos fios
Os fios devem começar com w_, seguido por de onde ele sai, e a lista de todos os lugares para onde ele vai entrar.

Exemplo: Fio que sai do MUX11 e vai para PC: w_MUX11_PC


### Entrada de sinais em MUX e derivados
A relação entrada-saída deve ser igual a da máquina de estado.

 Exemplo: Se na máquina de estados, no MUX11, quando vem o sinal 00, sai ALUResult; No código também deve ser isso.


 ### Possíveis erros:
 * Nome dos signextend e shiftleft
 * Literais que não são literais de vdd como 227