CREATE DATABASE functions
GO
USE functions

/* Exercício 1 -
a)Fazer uma Function que verifique, na tabela produtos (codigo, nome, valor unitário e qtd estoque)
Quantos produtos estão com estoque abaixo de um valor de entrada*/

CREATE TABLE produtos(
codigo INT,
nome VARCHAR(255),
valor_unitario DECIMAL(7,2),
qtd_estoque INT,
PRIMARY KEY(codigo)
)

CREATE FUNCTION qt_abaixo_estoque (@qt INT)
RETURNS INT
AS
BEGIN
	DECLARE @qt_abaixo INT
	SET @qt_abaixo = (SELECT COUNT(produtos.qtd_estoque) FROM produtos WHERE produtos.qtd_estoque < @qt)
	RETURN (@qt_abaixo)
END

SELECT * FROM produtos

INSERT INTO produtos VALUES
(1, 'batata', 33.40, 3),
(2, 'cenoura', 33.41, 2)

SELECT dbo.qt_abaixo_estoque(4)

/*b)Fazer uma function que liste o código, o nome e a quantidade dos produtos que estão com o estoque 
abaixo de um valor de entrada
*/

CREATE FUNCTION fn_itens_abaixo_estoque(@qt INT)
RETURNS @table TABLE(
codigo INT,
nome VARCHAR(255),
qtd_estoque INT
)
AS
BEGIN
	INSERT INTO @table (codigo, nome, qtd_estoque) 
		SELECT produtos.codigo, produtos.nome, produtos.qtd_estoque FROM produtos WHERE produtos.qtd_estoque < @qt
	RETURN
END

SELECT * FROM fn_itens_abaixo_estoque(3)

/* Exercício 2 - 
Considerando que uma Function não aceita nem Inserts, nem Procedures, como fazer o seguinte cenário?
"Criar, com apenas uma chamada de módulo, uma programação que baseada nas tabelas abaixo, insira os valores
Cod_cli, Cod_prod e qtd na tabela pedido e a cada inserção, apresente ao usuário a seguinte saída:
1 - Nome do Cliente
2 - Valor Total da Compra
3 - Tabela com os valores que devem conter a nota (Nome do Produto, Quantidade e Valor Total)

Tabelas: 
Cliente (Codigo, nome)
Produto (Codigo, nome, valor)
Pedido (Cod_cli, Cod_prod, Qtd, data (tipo date))*/

/* 
3) A partir das tabelas abaixo, faça:
Funcionário (Código, Nome, Salário)
Dependendente (Código_Funcionário, Nome_Dependente, Salário_Dependente)*/

CREATE TABLE funcionario (
codigo INT NOT NULL,
nome VARCHAR(100) NOT NULL,
salario DECIMAL(7,2) NOT NULL
PRIMARY KEY (codigo)
)

CREATE TABLE dependente (
codigo_funcionario INT NOT NULL,
nome_dependente VARCHAR(100) NOT NULL,
salario_dependente DECIMAL(7,2) NOT NULL
FOREIGN KEY (codigo_funcionario) REFERENCES funcionario (codigo)
)

INSERT INTO funcionario VALUES
(1001, 'a', 4500)

INSERT INTO dependente VALUES
(1001, 'b', 1000)

INSERT INTO dependente VALUES
(1001, 'c', 1500)

/*
a) Uma Function que Retorne uma tabela:
(Nome_Funcionário, Nome_Dependente, Salário_Funcionário, Salário_Dependente)*/

CREATE FUNCTION fn_funcionario()
RETURNS @table TABLE (
nome_funcionario VARCHAR(100),
nome_dependente VARCHAR(100),
salario_funcionario DECIMAL(7,2),
salario_dependente DECIMAL(7,2)
)
AS
BEGIN
	INSERT INTO @table (nome_funcionario, nome_dependente, salario_funcionario, salario_dependente)
		SELECT f.nome, d.nome_dependente, f.salario, d.salario_dependente FROM funcionario f, dependente d
	RETURN
END

SELECT * FROM fn_funcionario()

/*
b) Uma Scalar Function que Retorne a soma dos Salários dos dependentes, mais a do funcionário.*/

CREATE FUNCTION fn_soma_salario()
RETURNS DECIMAL(7,2)
AS
BEGIN
	DECLARE @sal_f AS DECIMAL(7,2),
			@sal_d AS DECIMAL(7,2),
			@soma AS DECIMAL(7,2)

	SET @sal_f = (SELECT salario FROM funcionario)
	SET @sal_d = (SELECT SUM (salario_dependente) FROM dependente)
	SET @soma = @sal_d + @sal_f
	RETURN (@soma)
END

SELECT dbo.fn_soma_salario() AS Soma

/*
4)A partir das tabelas abaixo, faça:
Cliente (CPF, nome, telefone, e-mail)
Produto (Código, nome, descrição, valor_unitário)
Venda (CPF_Cliente, Código_Produto, Quantidade, Data(Formato DATE))
a) Uma Function que Retorne uma tabela:
(Nome_Cliente, Nome_Produto, Quantidade, Valor_Total)
b) Uma Scalar Function que Retorne a soma dos produtos comprados na Última Compra
*/

CREATE TABLE cliente(
cpf CHAR(11),
nome VARCHAR(50) NOT NULL,
telefone CHAR(9) NOT NULL,
email VARCHAR(100) NOT NULL,
PRIMARY KEY (cpf))

CREATE TABLE produto(
codigo INT IDENTITY,
nome VARCHAR(50) NOT NULL,
descricao VARCHAR(200) NOT NULL,
valor_unitario DECIMAL(7,2) NOT NULL,
PRIMARY KEY (codigo)
)

CREATE TABLE venda(
cpf_cliente CHAR(11),
codigo_produto INT,
quantidade INT NOT NULL,
dt DATE,
PRIMARY KEY (cpf_cliente, codigo_produto),
FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
FOREIGN KEY (codigo_produto) REFERENCES produto(codigo))

INSERT INTO cliente VALUES
('11111111111', 'a', '999999999', 'a@gmail.com' ),
('22222222222', 'b', '888888888', 'b@gmail.com' )

INSERT INTO produto VALUES
('placa de video','rtx 3090', 5000.00),
('placa mãe',' mãe', 3000.00)

INSERT INTO venda VALUES
('11111111111',1,20,'06/03/2021'),
('22222222222',2,30,'06/03/2021'),
('11111111111',2,10,'12/03/2021')

select * from venda


CREATE FUNCTION fn_total()
RETURNS @table TABLE (
nome_cliente VARCHAR(50),
nome_produto VARCHAR(50),
quantidade INT,
valor_total DECIMAL(10,2)
)
AS
BEGIN
	INSERT INTO @table (nome_cliente, nome_produto, quantidade, valor_total)
		SELECT c.nome, p.codigo, v.quantidade, (v.quantidade*p.valor_unitario) FROM cliente c, produto p, venda v
		WHERE c.cpf = v.cpf_cliente AND v.codigo_produto = p.codigo
 
	RETURN
END


CREATE FUNCTION fn_somaultimacompra(@cpf INT)
RETURNS DECIMAL(20,2)
AS
BEGIN
	RETURN (SELECT SUM(p.valor_unitario * v.quantidade) FROM cliente c, produto p , venda v 
			WHERE c.cpf = v.cpf_cliente and v.codigo_produto = p.codigo and v.cpf_cliente = @cpf
			and v.dt = (select MAX(v.dt) from venda v where v.cpf_cliente = @cpf))
END