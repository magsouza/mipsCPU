### Isso são coisas que eu acho que podem dar erro

* A definição de alguns binários literais, em alguns lugares tá 5'b00001, outros tá 5'b0. Não sei se precisa escrever todos ou não.
* O Nome dos Shifts está com w, como se fosse um fio. Ao trocar no código, lembrar de regerar os blocos se não o bloco fica com o nome errado.
* Sinais de output do controle. O controle vai ter que ser alterado eventualmente para por todos os Outputs, aí vai precisar regerar o bloco e colocar todos os fios de novo. Cuidado.
* A Div e Mult. Algumas operações foram feitas assumindo que funciona, tipo o (~a + 1'b1) para ser complemento a 2. Isso compila(foi testado), mas não sabemos se dá o output esperado.
* A exception da Div de dividir por zero. Se ligar de colocar no estado, se rolar é pra ir pra a exception.
* O lance das exceptions em geral nos estados.
* O nome de alguns fios. Os de output do controle e que saem de registradores não estão muito padronizados.

### Importante
* Testar várias ordens de instrução e diferentes instruções.
