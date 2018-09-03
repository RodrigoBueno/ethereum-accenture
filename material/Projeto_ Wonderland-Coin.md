# PROJETO 4 - Smart Contract de um `Token Simplificado` `(Wonderland Coin)` 

**Curso Blockchain Developer**
Material produzido por [bbchain](http://www.bbchain.com.br).

> Os materiais publicados nesta página são protegidos por direitos autorais e são de propriedade da bbchain, juntamente com quaisquer outros direitos de propriedade intelectual sobre tais materiais. Todos os direitos reservados. Nenhuma parte desta página pode ser copiada, reproduzida, apresentada em público, transmitida, carregada, divulgada, distribuída, modificada ou tratada de nenhuma maneira sem o consentimento prévio por escrito da bbchain e, mesmo com tal consentimento, a fonte e os direitos de propriedade devem ser reconhecidos.

---
## Estrutura do projeto

1. Objetivo
2. Pré-requisito
3. Materiais
4. Conceitos abordados
	4.1. Tokens X Crytocurrencies
	4.2. Dinâmica de um token em uma rede distribuída
	4.3. Contratos Abstratos
	4.4. Eventos
	4.5. Tokens ERC20
	4.6. Limitações de Tokens em uma rede distribuída
		4.6.1 Problemas reais de utilização de Tokens
		4.6.2 Solução para os problemas identificados
	4.7. ICOs
5. Desafio: Wonderland Coin

# **1. Objetivo**

Este projeto tem como objetivo desenvolver um Smart Contract para entender a estrutura básica de um contrato em Solidity. Vamos programar, compilar, fazer deploy e interagir com um Smart Contract capaz de registrar a transferência de propriedade de imóveis dentro de um ambiente virtual simulado da plataforma Ethereum.

---

# **2. Pré-Requisitos**

Conceitos básicos de programação, Smart Contracts e plataforma Ethereum.

Conclusão dos Projetos 2 e 3.

---

# **3. Materiais**

* [Google Chrome] (https://www.google.com/chrome/)
* [Remix] (http://remix.ethereum.org)

# **4. Conceitos Abordados**

Antes de entrarmos no desafio deste projeto, vamos ver, separadamente, alguns conceitos básicos que iremos usar no projeto:

1. Tokens X Crytocurrencies
2. Dinâmica de um token em uma rede distribuída
3. Contratos Abstratos
4. Tokens ERC20
5. Eventos
6. Limitações de Tokens em uma rede distribuída
	6.1 Problemas reais de utilização de Tokens
	6.2 Solução para os problemas identificados
7. ICOs
8. Dinâmica de Compra e Venda de Token

## 4.1. Tokens X Cryptocurrencies

Coins (Cryptocoins ou AltCoins) e Tokens  são tipos de criptomoedas (Cryptocurrency) que podem ser usadas como ativos digitais.
A diferença entre Coin e Token está na relação de dependência da plataformas Blockchain onde operam, podemos dizer que:

- Coins: são criptomoedas independentes que operam em suas próprias Blockchains.

- Tokens: são criptomoedas que dependem de uma plataforma Blockchain para operar, facilitando a criação de aplicações descentralizadas.

Simplificando, os Tokens são normalmente Smart Contracts que controlam a emissão, a propriedade, a  transferência e a queima de valores.

## 4.2. Dinâmica de um token em uma rede distribuída

Entendendo que um Token é um Smart Contract, conseguimos descrever como ele deve funcionar na rede, vamos precisar:

1. Armazenar o saldo de cada endereço
2. Definir uma forma de enviar token para um endereço
3. Garantir que apenas o dono do token possa realizar a transferência

Apesar do modelo ser simples, com o grande número de pessoas trabalhando em projetos similares, temos muitas variações possíveis de código para descrever um token, e isso se extende para outras implementações. 
Buscando uma forma de organizar e facilitar a integração entre Smart Contracts na rede, a comunidade se organizou para criar as `ERC - Ethereum Request for Comments`, onde as pessoas realizam sugestões de padronizações pela comunidade.
Uma delas é a `ERC20`que define uma forma padrão para construção de tokens dentro da rede Ethereum.

Antes de explicarmos como funciona **interfaces** no Ethereum, precisamos entender o conceito de `Contratos Abstratos` e `Eventos`.

## 4.3. Contratos Abstratos

Contratos são considerados abstratos quando pelo menos uma de suas funções não têm uma implementação, como no seguinte exemplo: 

```javascript 
pragma solidity ^0.4.18;

contract Token { 
	uint public tokensTotal;
	mapping(address => uint) public saldo;
	
	function transferir(uint valor, address para);
}
```

Esses contratos não poderão ser compilados (mesmo que aja outras funções implementadas), mas poderão ser usados como base para outros contratos. Exemplo:

```javascript 
pragma solidity ^0.4.18;
import "./Token.sol";

contract MeuToken is Token { 
	
	function transferir(uint valor, address para) {
		require(saldo[msg.sender] >= valor, "não há saldo suficiente");
		saldo[msg.sender] -= valor;
		saldo[para] += valor;
	}

	constructor(uint total) public {
	    tokensTotal = total;
	    saldo[msg.sender] = tokensTotal;
	}
}
```
Comparando com linguagens orientadas a objeto, contratos que não possuem a definição de alguma função é visto como uma `Classe Abstrata` ou uma `Interface`. 

Os contratos Abstratos vão nos ajudar a padronizar nomes de funções e valores de retorno, isto facilita chamadas ao seu Smart Contract por outros Smart Contract, além de gerar interoperabilidade com ferramentas que já são utilizadas para mapear os serviços disponíveis na plataforma Ethereum.

Veja mais detalhes em: http://solidity.readthedocs.io/en/v0.4.24/contracts.html

## 4.4. Eventos

O Ethereum permite que aplicações externas (usando `web3.js`, por exemplo) consigam monitorar a execução de eventos específicos de um Smart Contract. 

Exemplo (sintaxe):

```javascript 
pragma solidity ^0.4.18;

contract MeuToken is Token { 
	
	function transferir(uint valor, address para) {
		require(saldo[msg.sender] >= valor, "não há saldo suficiente");
		saldo[msg.sender] -= valor;
		saldo[para] += valor;
		emit Transferido(valor, para);
	}

	constructor(uint total) public {
	    tokensTotal = total;
	    saldo[msg.sender] = tokensTotal;
	}
	event Transferido(
        uint valor,
        address para
    );
}
```

A título de exemplificação (não entraremos a fundo nesse assunto), a forma que uma aplicação conseguiria capturar esse evento usando `web3.js` seria assim:
```javascript 
var abi = /* abi as generated by the compiler */;
var ClientReceipt = web3.eth.contract(abi);
var clientReceipt = ClientReceipt.at("0x1234...ab67" /* address */);

var event = clientReceipt.Transferido();

// watch for changes
event.watch(function(error, result){
    // result will contain various information
    // including the argumets given to the `Deposit`
    // call.
    if (!error)
        console.log(result);
});

// Or pass a callback to start watching immediately
var event = clientReceipt.Transferido(function(error, result) {
    if (!error)
        console.log(result);
});
```

Este tipo de construção permite melhor controle nos seus DApps, simplificando a forma como eles se comunicam com o Ethereum.

Apesar de se chamar evento, a forma como os conectores sabem sobre o disparo do evento é através da leitura dos blocos recebidos. Junto com as transações, os eventos disparados também são armazenados na blockchain, desta forma, não existe o risco de se perder um evento por seu serviço não estar disponível no momento em que ele consolidado no blockchain.

Veja mais detalhes em: http://solidity.readthedocs.io/en/v0.4.24/contracts.html#events



## 4.5. Tokens ERC20

Um token `ERC20` precisa implementara seguinte interface:
```javascript
contract ERC20Interface {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
 
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
```

Vamos entender mais a fundo qual a ideia por trás de cada uma das funções da interface:

1. **`function totalSupply() public constant returns (uint)`**: Retorna o total de tokens emitidos.
2. **`balanceOf(address _owner) constant returns (uint256 balance)`**: Retorna o saldo de tokens de um determinado endereço (`_owner`).
3.  **`transfer(address _to, uint256 _value) returns (bool success)`**: Transfere uma quantidade (`_value`) de tokens de quem está chamando a função (`msg.sender`) para um determinado endereço (`_to`). Retorna `TRUE` se a transferência for bem sucedida.  
4.  **`approve(address _spender, uint256 _value) returns (bool success)`**: Pré-aprova que um determinado endereço (`_spender`) transfira uma certa quantidade (`_value`) de tokens para outro endereço do saldo do endereço de quem chamou a função (`msg.sender`). Retorna `TRUE` se a aprovação for bem sucedida. 
5. **`allowance(address *_owner*, address *_spender*) constant returns (uint256 remaining)`**: Retorna a quantidade (`_value`) de tokens que um endereço (`_spender`) pode transferir do saldo de outro endereço (`_owner`).
6. **`transferFrom(address _from, address _to, uint256 _value) returns (bool success)`**: Transfere uma quantidade (`_value`) de tokens de um endereço (`_from`) para outro (`_to`). Normalmente essa função implementa uma lógica que permite essa transação quando houver uma pré-aprovação (com a função `approve`) do endereço de quem está sendo transferido (`_from`) para o endereço de quem está chamando a função (`msg.sender`). 

Além das funções o padrão ERC20 também contempla a implementação de dois **eventos***:

1. **`Transfer(address indexed _from, address indexed _to, uint256 _value)`**: Evento disparado quando ocorre uma transferência (função `transfer`).
2.  **`Approval(address indexed _owner, address indexed _spender, uint256 _value)`**: Evento disparado quando há uma aprovação (função `approve`).

É comum que outras variáveis sejam utilizadas como complemento ao ERC20, para a identificação do token, como **`name`**, **`symbol`** e **`decimals`**.

1. **`name`**: nome do token.
2. **`symbol`**: sigla do token.
3. **`decimals`**: quantidade de decimais considerados no `totalSupply`. Por exemplo, se `totalSupply` for `1000000` e decimals for 3, o total de tokens emitidos seria 1.000, com três casas decimais, ou seja, 1.000,000. 

> Obs.: O `ether` tem 18 casas decimais. `0,000000000000000001 ether` é o menor valor possível em `ether` e é chamado de `wei`. Ou seja, `1 ether = 1.000.000.000.000.000.000 wei`. Veja detalhes em: http://ethdocs.org/en/latest/ether.html 

## 4.6. Limitações de Tokens em uma rede distribuída

Apenas a utilização de um Smart Contract para especificar o seu Token na rede Ethereum trás alguns problemas, sendo eles de escalabilidade e de segurança.

### 4.6.1 Problemas reais de utilização de Tokens

Toda execução de transferência precisa ser realizada pelo dono dos Tokens, ou seja, se sempre que você for transferir uma moeda é necessário a intervenção de um ser humano.
Vamos imaginar o cenário onde Alice deseja comprar uma Pizza utilizando os seus tokens criados utilizando um Token padrão ERC20.

- [ ] Alice cria os seus Tokens na rede com um limite total de 1000 moedas.
- [ ] Alice combina com Bob que irá utilizar 50 de seus Tokens para comprar uma pizza.
- [ ] Bob acredita, devido a escassez de Tokens da Alice, que uma pizza vale 50 Tokens.
- [ ] Bob produz a pizza.
- [ ] Bob entrega a pizza a Alice.
- [ ] Alice executa a função `transfer` e faz o pagamento de 50 Tokens.

Parece que funciona, agora vamos imaginar que Bob gostaria de vender os seus tokens para Chuck.

- [ ] Bob negocia com Chuck a venda 25 tokens por 20 reais.
- [ ] Chuck acredita que os Tokens de Alice possuem algum valor e concorda com a troca.
- [ ] Chuck faz uma transferência bancária de 20 reais para Bob.
- [ ] Bob executa a função `transfer` e faz o pagamento de 25 Tokens.

Podemos detectar alguns problemas com essa abordagem:

1. Não existe um valor comum para os Tokens criados por Alice, algumas pessoas negociam com bens de consumo, outras com dinheiro, dificultando ter uma ideia do valor real do token.
2. Toda troca de token precisa ser feita por um ser humano dono do Token.
3. Existe a possibilidade de fraude, Bob pode não executar a transferência dos 25 tokens depois de ter recebido os 20 reais.

Temos um problema de **escala** e um problema **segurança**. Se houver uma alta demanda pelos tokens, Alice vai ter um processo administrativo alto, e temos o risco de perder as informações que estão sendo negociadas em duas transações diferentes, não existe **atomicidade**.

### 4.6.2 Solução para os problemas identificados

Para entender a solução deste problema, é bom relembrarmos a forma como os `Smart Contracts` e as `Carteiras` ficam armazenadas na rede do Ethereum.
Todo endereço de **0x000000000000000000000000000000000000000** até **0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF** representam uma entidade dentro da rede, que pode receber *Ether* e pode enviar *Ether* caso a sua chave privada seja conhecida. Os mesmos endereços são compartilhados entre carteiras pessoais (que são aquelas que você possui a chave) e Smart Contracts, que tem a capacidade de fazer uma execução de código caso ele seja acionado corretamente.
Conhecendo isto, podemos ver que é possível enviar *Ether* para um Smart Contract, e isto irá facilitar a resolução dos nossos problemas.

Ao invés de deixar Alice como dona de todos os Tokens, podemos construir um Smart Contract que permita a compra de Tokens, um **ICO**. 

## 4.7 ICOs

ICOs são Smart Contracts que tem como objetivo fazer a distribuição de um Token dentro de uma rede Blockchain, onde ele realiza a troca da moeda corrente da plataforma por Tokens.
Este Smart Contract irá definir regras para transferência, como o custo em moeda para compra de cada Token e o limite de compra por cada endereço, desta forma não é mais necessário a interação entre duas pessoas para a compra de um Token.
Voltando no exemplo da Alice, podemos dizer que ela definiu que cada um de seus tokens devem ser comprados com 0,1 Ether. Assim a dinâmica para compra de seus tokens se torna.

- [ ] Bob envia 1 Ether para o ICO de Alice.
- [ ] O Smart Contract calcula que para 1 Ether ele deve enviar 10 Tokens para o endereço de Bob.
- [ ] O Smart Contract envia 10 tokens para o endereço de Bob. 

Desta forma, não é necessário que Bob fale com Alice para realizar a transação, também não existe o risco de fraude sobre a troca de valores, já que toda a troca ocorre na mesma execução do Smart Contract.

Apesar de parecer simples, existem muito modelos de ICO, como o `Burnable` e o `Mintable`, para saber mais sobre estes outros modelos acesse https://blog.zeppelin.solutions/how-to-create-token-and-initial-coin-offering-contracts-using-truffle-openzeppelin-1b7a5dae99b6?gi=6368f31a2c1a

# 5. Token Simplificado

As instruções abaixo são apenas para referência. É fortemente recomendado resolver o desafio sem esse auxílio. 

1.  - [ ] Abra o Google Chrome e entre em (http://remix.ethereum.org).
2.  - [ ] Crie um novo arquivo `WonderlandCoin.sol`.
3.  - [ ] Digite o seguinte código Solidity: 

```javascript 
pragma solidity ^0.4.18;

contract MeuToken {  
 
	// VARIÁVEIS
	uint public tokensTotal;
	mapping(address => uint) public saldo;

	// MODIFIER
	modifier temSaldo(uint valor) {
		require(saldo[msg.sender] >= valor, "não há saldo suficiente");
		_;
	}
	
	// FUNÇÕES
	function transferir(uint valor, address para) temSaldo(valor) {
		saldo[msg.sender] -= valor;
		saldo[para] += valor;
	}

	constructor(uint total) public {
	    tokensTotal = total;
	    saldo[msg.sender] = tokensTotal;
	}
}
```
4.  - [ ] Certifique-se que o `Auto compile` está selecionado na aba `Compile`
5.  - [ ] Certifique-se que o `Environment` está setado com `Javascript VM` na aba `Run`
6.  - [ ] Selecione a primeira `Account` disponível na aba `Run`
7.  - [ ] Crie uma instância do Smart Contract com o total `1000`
8.  - [ ] Verifique o saldo do endereço da primeira `Account` 
10.  - [ ] Verifique o saldo do endereço da segunda `Account` 
11.  - [ ] Mantenha a primeira `Account` selecionada e execute a função `transferir` com o `valor` de `100` e `para` com o endereço da segunda `Account`
12.  - [ ] Confira novamente os saldos dos endereços da primeira e segunda `Accounts`
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTcwNTQxODc2NSwxMzY4NzY1NDgsMzAyMz
Y3NTc0XX0=
-->