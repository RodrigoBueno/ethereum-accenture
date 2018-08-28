pragma solidity ^0.4.24;

contract JogoDaVelhaAbstrato {

	// VARIÁVEIS 
	address public jogador1; // endereço do jogador 1
	address public jogador2; // endereço do jogador 2
	address public jogadorDaVez; // endereço do jogador da vez
	uint public valorInscricao; // valor da inscricao em wei
	bool public fimDoJogo = false; // jogo terminou (empate ou ganhador)
	
	mapping(uint => mapping(uint => address)) public tabuleiro; // tabuleiro[posicao_linha][posicao_coluna] = endereço_jogador
    
	// FUNÇÕES 
	
	// Devolver dinheiro
	function() payable public;
	
	// Atribui msg.sender ao jogador 1 ou 2, define jogador da vez e emit ComecarJogo
	function inscrever() payable public;
	
	// Atribui valor no tabuleiro, verifica se o jogador ganhou ou houve empate e atualiza jogador da vez
	// Se houve empate, devolver dinheiro para cada jogador
	// Se o jogador da vez ganhou, transferir todo o dinheiro para devolver
	// Emitir eventos quando necessário
	function jogar(uint linha, uint coluna) payable public;
	
	// Verifica se o tabuleiro está totalmente preenchido
	function verificarEmpate() public returns(bool);
	
	// Verifia se o jogador atual ganhou
	function verificarSeGanhou() public returns(bool) {
	    return (
	        // linha 0
	        ( tabuleiro[0][0] == msg.sender && tabuleiro[0][1]==msg.sender && tabuleiro[0][2]==msg.sender ) || 
	        // linha 1
	        ( tabuleiro[1][0] == msg.sender && tabuleiro[1][1]==msg.sender && tabuleiro[1][2]==msg.sender ) || 
	        // linha 2
	        ( tabuleiro[2][0] == msg.sender && tabuleiro[2][1]==msg.sender && tabuleiro[2][2]==msg.sender ) || 
	        // coluna 0
	        ( tabuleiro[0][0] == msg.sender && tabuleiro[1][0]==msg.sender && tabuleiro[2][0]==msg.sender ) || 
	        // coluna 1
	        ( tabuleiro[0][1] == msg.sender && tabuleiro[1][1]==msg.sender && tabuleiro[2][1]==msg.sender ) || 
	        // coluna 2
	        ( tabuleiro[0][2] == msg.sender && tabuleiro[1][2]==msg.sender && tabuleiro[2][2]==msg.sender ) || 
	        // diagonal esquerda-cima, direita-baixo
	        ( tabuleiro[0][0] == msg.sender && tabuleiro[1][1]==msg.sender && tabuleiro[2][2]==msg.sender ) || 
	        // diagonal direita-cima, esquerda, baixo
	        ( tabuleiro[0][2] == msg.sender && tabuleiro[1][1]==msg.sender && tabuleiro[2][0]==msg.sender )
	   );
	}
	
	// EVENTOS
	event ComecarJogo();
	event JogadorDaVez(address _jogadorDaVez);
	event FimDeJogo();
}