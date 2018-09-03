# **10. Projeto V - ICO com OpenZeppelin**

### 10. 1. Objetivo
Construir um Smart Contract para realizar vendas de um Token ERC20 a preço fixo utilizando o `SafeMath` e uma função `fallback` para evitar gastos indevidos acidentais de `ether`. 

### 10.2. Conhecimentos abordados
Antes de entrarmos no desafio deste projeto, vamos ver, separadamente, alguns conceitos mais avançados que serão utilizados neste projeto.

1. Usar o `SafeMath` em um Smart Contract
2. Função `fallback`

#### 10.2.1. Usar o `SafeMath` em um Smart Contract
Para que as variáveis do tipo `uint` incorporem as funções de multiplicação (`mul`), divisão (`div`), adição (`add`) e subtração (`sub`), é necessário usar a operação `using for` conforme exemplo a seguir: 

```javascript 
pragma solidity ^0.4.23;

import "localhost/math/SafeMath.sol";

contract CalculadoraSegura { 
	using SafeMath for uint;	
}
```
`using A for B` permite incorporar funções de uma biblioteca `A` em qualquer tipo de variável `B`.

Dessa maneira, toda variável `uint` irá incorporar as funções da biblioteca `SafeMath`, conforme o exemplo abaixo:

```javascript 
pragma solidity ^0.4.23;

import "localhost/math/SafeMath.sol";

contract CalculadoraSegura { 
	using SafeMath for uint;
	
	function somar(uint a, uint b) returns(uint) {
		return a.add(b);
	};
	function subtrair(uint a, uint b) returns(uint) {
		return a.sub(b);
	};
	function multiplicar(uint a, uint b) returns(uint) {
		return a.mul(b);
	};
	function subtrair(uint a, uint b) returns(uint) {
		return a.sub(b);
	};
}
```

Veja mais detalhes em: https://solidity.readthedocs.io/en/v0.4.24/contracts.html?#using-for

#### 10.2.2. Função `fallback`
Uma função `fallback` é executada sempre que uma chamada é feita para uma função que não existe no contrato. 

Para ser uma função `fallback`, a função não pode ter um nome e nem argumentos, e não pode retornar nada. Essa função é bastante usada para lidar com `ethers` enviados incorretamente para um Smart Contract, como o exemplo a seguir:

```javascript 
pragma solidity ^0.4.23;

contract MeuContrato { 
	// se ethers forem enviados para uma função que não existe no contrato...
	function () payable {
		devolverDinheiro();
	}
	// os ethers são devolvidos para quem chamou a função
	function devolverDinheiro() payable{
		msg.sender.transfer(msg.value);
	}
}
```

Veja mais detalhes em: https://solidity.readthedocs.io/en/v0.4.24/contracts.html?highlight=fallback#fallback-function 

### 10.3. Desafio: ICO com OpenZeppelin
O objetivo deste desafio é criar um Smart Contract para vender os Tokens ERC20 `MeuTokenERC20` a preço fixo. utilizando a biblioteca `SafeMath` para realizar operações matemáticas, e a função `fallback`, para realizar compras de tokens quando uma chamada for feita para uma função que não existe no contrato.

Considere como ponto de partida,  o desafio do **9. Projeto IV - Token ERC20 com OpenZeppelin**. 

Certifique-se que o `remixd` está compartilhando o diretório de contratos do OpenZeppelin.

Construa um Smart Contract com o nome **`ICOERC20`**, importe o arquivo  **`./MeuTokenERC20.sol`** e o **`math/SafeMath.sol`** do OpenZeppelin.

Use o `SafeMath` para toda variável do tipo `uint`.

Defina uma variável **`token`** do tipo `MeuTokenERC20` para armazenar a instancia do token ERC20; uma variável **`preco`** do tipo `uint` para armazenar o quanto de tokens 1 `wei` compra; uma variável **`proprietario`** do tipo `address` para armazenar o endereço de quem vai receber os valores dos tokens vendidos; e uma variável **`weiArrecadado`** do tipo `uint` para armazenar a quantidade de `wei` arrecadados durante o ICO. 

Na função construtora do Smart Contract `ICOERC20`, receba como parâmetros o preço e o endereço do proprietário e atribua as respectivas variáveis. Crie uma nova instância do `MeuTokenERC20` e transfira a metade dos tokens para o proprietário do ICO.

Crie uma função para comprar tokens e transferi-los para um determinado endereço passado por parâmetro. A quantidade de tokens deve ser calculada com base na quantidade de `wei`enviados e no preço definido. O valor `wei` deverá ser transferido ao proprietário do ICO.

Defina uma função `fallback` para realizar a compra de tokens para o `msg.sender`.   

### 10.4. Solução: ICO com OpenZeppelin

As instruções abaixo são apenas para referência. É fortemente recomendado resolver o desafio sem esse auxílio. 

1.  - [ ] Certifique-se que o desafio do **9. Projeto IV - Token ERC20 com OpenZeppelin** foi realizado com sucesso 
2.  - [ ] Crie um novo arquivo `ICOERC20.sol`.
3.  - [ ] Digite o seguinte código Solidity: 

```javascript 
pragma solidity ^0.4.23;

import "./MeuTokenERC20.sol";
import "localhost/math/SafeMath.sol";

contract ICOERC20 {
    // Habilita o uso do SafeMath em todas variaveis uint
    using SafeMath for uint;
    
    MeuTokenERC20 public token; // Token vendido
    address public proprietario; // Proprietário do ICO
    uint public preco; // Preco do token em wei
    uint public weiArrecadado; // Total de wei arrecadado
    
    event TokenComprado(address indexed comprador,address indexed recebedor,uint quantidadeWei,uint quantidadeToken);
    
    constructor(uint _preco, address _proprietario) public {
        require(_preco > 0);
        require(_proprietario != address(0));
        
        // define preço que o token ser vendido em wei 
        preco = _preco; 
        
        // define quem sera o proprietario/benificiario do ICO
        proprietario = _proprietario; 
        
        // cria o token
        token = new MeuTokenERC20();
        
        // transfere metade dos tokens para o proprietario
        token.transfer(proprietario, token.totalSupply().div(2));
    }
    
    // Qualquer função chamada que não foi implementada no contrato redireciona para função
    function () external payable {
        comprarTokens(msg.sender);
    }
    // endereco do comprador foi enviado
    modifier existeRecebedor(address _recebedor) {
        require(_recebedor != address(0));
        _;
    }
    // wei foi enviado
    modifier weiEnviado() {
	    require(msg.value != 0);
	    _;
    }
    // realizar compra
    function comprarTokens(address _recebedor) weiEnviado() existeRecebedor(_recebedor) public  payable {
        // wei enviados
        uint weiRecebidos = msg.value;
        
        // calcula a quantiade de tokens que wei enviados pode comprar
        uint tokens = weiRecebidos.mul(preco);
        
        // atualiza a quantidade de wei arrecadado
        weiArrecadado = weiArrecadado.add(weiRecebidos);
        
        // transfere tokens para o recebedor/beneficiario
        token.transfer(_recebedor, tokens);
        
        // emite evento
        emit TokenComprado(msg.sender,_recebedor,weiRecebidos,tokens);
        
        // transfere wei para proprietario do ICO
        proprietario.transfer(msg.value);
    }
}
```
4.  - [ ] Certifique-se que o `Auto compile` está selecionado na aba `Compile`
5.  - [ ] Certifique-se que o `Environment` está setado com `Javascript VM` na aba `Run`
6.  - [ ] Selecione a primeira `Account` disponível na aba `Run`
7.  - [ ] Crie uma instância do Smart Contract `ICOERC20`, passando `3` para o parâmetro `_preco` e o endereço da primeira `Account` para o parâmetro `_proprietario` 
8.  - [ ] Clique em `token` para ver o endereço da instância do Smart Contract `MeuTokenERC20`
9.  - [ ] Copie o endereço e cole no campo `Load contract from address`, selecione o Smart Contract `MeuTokenERC20` e clique no botão `At Address`, para carregar a instancia do Smart Contract `MeuTokenERC20`
10. - [ ] Veja o saldo do `MeuTokenERC20` para o endereço do `ICOERC20` e para o endereço da primeira `Account`
11.  - [ ] Selecione a segunda `Account da lista`
12.  - [ ] Coloque no campo `value` o valor de `8` `ether`
13.  - [ ] Clique em `comprarTokens` passando o endereço da segunda `Account` por parâmetro
14.  - [ ] Verifique o saldo em Ethers da primeira e segunda `Accounts`
15.  - [ ] Verifique o saldo de Tokens do endereço da instância do `ICOERC20` da da segunda `Account`
<!--stackedit_data:
eyJoaXN0b3J5IjpbMzcxODE3ODcyLDczMDk5ODExNl19
-->