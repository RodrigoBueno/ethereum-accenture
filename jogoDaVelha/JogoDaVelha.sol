pragma solidity ^0.4.24;
import "./JogoDaVelhaAbstrato.sol";
import "./SafeMath.sol";

contract JogoDaVelha is JogoDaVelhaAbstrato {
    using SafeMath for uint;
    constructor (uint _valorInscricao) public {
	    require(_valorInscricao > 0);
        valorInscricao = _valorInscricao;
	}
    // MODIFIER
    modifier inscricaoAberta() {
        require(jogador1==address(0) || jogador2==address(0), "**Inscricao fechada");
        _;
    }
    modifier pagouInscricao() {
        require(msg.value == valorInscricao,"** Não pagou valor exata da inscricao");
        _;
    }
    modifier jogadaValida(uint linha, uint coluna) {
        require(fimDoJogo == false, "** Jogo termonou");
        require(msg.sender == jogadorDaVez, "** Você não é o jogador da vez");
        require(linha>=0 && linha <=2 && coluna >= 0 && linha <= 2, "** Posição inválida");
        require(tabuleiro[linha][coluna]==address(0), "** Posição já jogada");
        _;
    }
    modifier jogoComecado() {
        require(jogador1!=address(0) && jogador2!=address(0), "** Jogo ainda não comecou");
        _;
    }
    
	// FUNÇÕES 

	function () payable public {
	    msg.sender.transfer(msg.value);
	}
	
	function inscrever() inscricaoAberta pagouInscricao payable public{
		if(jogador1==address(0)) {
		    jogador1 = msg.sender;
		    jogadorDaVez = jogador1;
		} else if(jogador2==address(0)) {
		    jogador2 = msg.sender;
		    emit ComecarJogo();
		}
	}
	function jogar(uint linha, uint coluna) jogoComecado jogadaValida(linha,coluna) payable public {
	    tabuleiro[linha][coluna] = msg.sender;
	    
	    if(verificarSeGanhou()) {
	        msg.sender.transfer(valorInscricao.add(valorInscricao));
	        fimDoJogo = true;
	        emit FimDeJogo();
	    } if(verificarEmpate()) {
	        jogador1.transfer(valorInscricao);
	        jogador2.transfer(valorInscricao);
	        fimDoJogo = true;
	        emit FimDeJogo();
	    } else {
            if(jogadorDaVez == jogador1) {
	            jogadorDaVez = jogador2;
    	    } else {
    	        jogadorDaVez = jogador1;
    	    }
    	    emit JogadorDaVez(jogadorDaVez);
	    }
	}
	function verificarEmpate() public returns(bool){
	    return 
	        tabuleiro[0][0]!=address(0) && 
	        tabuleiro[0][1]!=address(0) && 
	        tabuleiro[0][2]!=address(0) && 
	        tabuleiro[1][0]!=address(0) && 
	        tabuleiro[1][1]!=address(0) && 
	        tabuleiro[1][2]!=address(0) && 
	        tabuleiro[2][0]!=address(0) && 
	        tabuleiro[2][1]!=address(0) && 
	        tabuleiro[2][2]!=address(0);
	}
}