# Deploy de Smart Contracts em redes públicas Ethereum

**Curso Blockchain Developer**
Material produzido por [bbchain](http://www.bbchain.com.br).

> Os materiais publicados nesta página são protegidos por direitos autorais e são de propriedade da bbchain, juntamente com quaisquer outros direitos de propriedade intelectual sobre tais materiais. Todos os direitos reservados. Nenhuma parte desta página pode ser copiada, reproduzida, apresentada em público, transmitida, carregada, divulgada, distribuída, modificada ou tratada de nenhuma maneira sem o consentimento prévio por escrito da bbchain e, mesmo com tal consentimento, a fonte e os direitos de propriedade devem ser reconhecidos.

---
## Estrutura do projeto

1. Objetivo
2. Pré-requisito
3. Materiais
4. Projeto: Deploy de Smart Contracts em redes públicas Ethereum
	4.1. Criar cofre de contas (Vault) no MetaMask
		4.1.1. Aceitar os termos
		4.1.2. Criar senha
		4.1.3. Salvar MNEMONIC
	4.2. Ver conta
		4.2.1. Ver conta no Etherscan
		4.2.2. Ver QR code
		4.2.3. Copiar endereço
		4.2.4. Exportar chave privada
	4.3. Editar nome da conta
	4.4. Criar conta
	4.5. Importar conta
	4.6. Alterar a rede
	4.7. Enviar `ether` entre contas
	4.8. Conectar Remix com MetaMask
	4.9. Fazer deploy de um Smart Contract em uma rede TestNet a partir do Remix
	4.10. Interagir com um Smart Contract em uma rede TestNet a partir do Remix
5. Desafio extra (opcional)
	5.1. Conectar o MetaMask em uma rede virtual local com o Ganache
	5.2. Conectar o Remix diretamente em uma rede virtual local com o Ganache

# **1. Objetivo**

Este projeto tem como objetivo fazer o deploy de Smart Contracts em qualquer rede Ethereum a partir do Remix usando o plugin MetaMask. Vamos também criar e importar endereços no MetaMask e fazer transações de envio de `ethers` entre endereços. 

---

# **2. Pré-Requisitos**

Conceitos básicos de blockchain, Smart Contracts e plataforma Ethereum.

---

# **3. Materiais**

* [Google Chrome] (https://www.google.com/chrome)
* [Remix] (http://remix.ethereum.org)
* [MetaMask] (https://metamask.io)

# **4. Projeto: Deploy de Smart Contracts em redes públicas Ethereum**

Neste projeto iremos usar o MetaMask e Remix para incrementalmente criar e gerenciar contas, fazer deploy de contratos e interagir com contratos em redes Ethereum públicas. As instruções deste projeto foram agrupadas da seguinte maneira:

1. Criar cofre de contas (Vault) no MetaMask
2. Ver conta
3. Editar nome da conta
4. Criar conta
5. Importar conta
6. Alterar a rede
7. Enviar `ether` entre contas
8. Conectar Remix com MetaMask
9. Fazer deploy de um Smart Contract em uma rede TestNet a partir do Remix
10. Interagir com um Smart Contract em uma rede TestNet a partir do Remix

## 4.1. Criar cofre de contas (Vault) no MetaMask




### 4.1.1. Aceitar os termos
1. - [ ] Clique no ícone do MetaMask 
2. - [ ] Clique em `Accept` para aceitar o termo de uso
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-1.png?alt=media)
3. - [ ] Clique em `Accept` para aceitar o termo de privacidade
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-2.png?alt=media =350x) 
4. - [ ] Clique em `Accept` para aceitar os riscos de fraude (phishing). Veja detalhes em: https://metamask.io/phishing.html
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-4.png?alt=media =350x)

### 4.1.2. Criar senha
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-5.png?alt=media =350x)
### 4.1.3. Salvar MNEMONIC
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-6.png?alt=media =350x)
## 4.2. Ver conta
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-7.png?alt=media =350x)
### 4.2.1. Ver conta no Etherscan
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-8.png?alt=media =350x)
### 4.2.2. Ver QR code
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-8.png?alt=media =350x)
### 4.2.3. Copiar endereço
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-8.png?alt=media =350x)
### 4.2.4. Exportar chave privada
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-8.png?alt=media =350x)
## 4.3. Editar nome da conta
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-8.png?alt=media =350x)
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-9.png?alt=media =350x)
## 4.4. Criar conta

![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-10.png?alt=media =350x)
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-11.png?alt=media =350x)

## 4.5. Importar conta

![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-12.png?alt=media =350x)
![](https://firebasestorage.googleapis.com/v0/b/bbchain-lab-crypto.appspot.com/o/metamask%2Fmetamask-13.png?alt=media =350x)
## 4.6. Alterar a rede
![]()
## 4.7. Enviar `ether` entre contas
![]()
## 4.8. Conectar Remix com MetaMask
![]()
## 4.9. Fazer deploy de um Smart Contract em uma rede TestNet a partir do Remix
![]()
## 4.10. Interagir com um Smart Contract em uma rede TestNet a partir do Remix
![]()





As instruções abaixo são apenas para referência. É fortemente recomendado resolver o desafio sem esse auxílio. 

1.  - [ ] Certifique-se que a extensão do MetaMask está instalada no navegador
2.  - [ ] Clique no ícone do MetaMask
![enter image description here](https://cdn-images-1.medium.com/max/1600/1*yH7UI59waT4WTidOjmGApQ.jpeg)
3.  - [ ] Aceite os termos de uso e privacidade
4.  - [ ] Insira uma senha
5. - [ ] Salve o `seed` em arquivo
6. - [ ] Clique em `I'VE COPIED SOMEWHERE SAFE`
7. - [ ] Altere a rede de `Main Ethereum Network` para `Ropsten Test Network`
8. - [ ] Copie o endereço da `Account 1`
9. - [ ] Entre em http://faucet.ropsten.be:3001/, cole o seu endereço e solicite 1 ether
10. - [ ] Entre no http://remix.ethereum.org
11.  - [ ] Na aba `Run`, selecione `Inject Web3` como `Environment` para conectar com o MetaMask
12.  - [ ]  Crie uma instância do Smart Contract `ICOERC20`, passando `3` para o parâmetro `_preco` e o endereço da `Account 1` para o parâmetro `_proprietario` 
13. - [ ] Clique em `SUBMIT` na tela de notificação do MetaMask
14. - [ ] Confira o deploy do seu Smart Contract no [Etherscan](https://ropsten.etherscan.io/), copiando o endereço do contrato no Remix e colando no campo de busca `Search by Address / Txhash / Block / Token`
15. - [ ] Reproduza as interações com os Smart Contracts realizadas no desafio do **10. Projeto V - ICO com OpenZeppelin**, agora em uma Rede Ethereum

Para realizar o deploy na **Main Ethereum Network**, basta alterar a rede do MetaMask de `Ropsten Test Network` para `Main Ethereum Network` e possuir um `Account` com saldo em `ether`.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTEzNTcwOTMzNywtOTQ0NTg4MTksLTk5ND
Q4NDkwOSwxOTE3MzIwODU5LC0xNDYwOTU1NjcwLDc2NjU3ODMw
NSw5ODAyMjIxNjMsLTE5MjIxNTY3NzIsMjYyNDc0MjksMTg3OD
QzODc0NiwtMjA5OTA2NzEwNywtMTEwNTEyNjcxNSwtNTY2NDUx
MTgyLDEwMTA4MjY4MTYsLTEyNjc3ODEzMzFdfQ==
-->