/*
Considere a tabela Produto com os seguintes atributos:
Produto (Codigo | Nome | Valor)
Considere a tabela ENTRADA e a tabela SAÍDA com os seguintes atributos:
(Codigo_Transacao | Codigo_Produto | Quantidade | Valor_Total)
Cada produto que a empresa compra, entra na tabela ENTRADA. Cada produto que a empresa vende, entra na tabela SAIDA.
Criar uma procedure que receba um código
 (‘e’ para ENTRADA e ‘s’ para SAIDA), 
 criar uma exceção de erro para código inválido, receba o codigo_transacao, codigo_produto e a quantidade
  e preencha a tabela correta, com o valor_total de cada transação de cada produto.
*/

CREATE DATABASE empresa
GO
USE empresa

CREATE TABLE produto(
codigo INT,
nome VARCHAR(80),
valor DECIMAL(7,2),
PRIMARY KEY(codigo)
)

CREATE TABLE entrada(
Codigo_Transacao INT ,
Codigo_Produto INT,
Quantidade INT,
Valor_total DECIMAL(7,2),
PRIMARY KEY(Codigo_Transacao)
)

CREATE TABLE saida(
Codigo_Transacao INT,
Codigo_Produto INT,
Quantidade INT,
Valor_total DECIMAL(7,2)
PRIMARY KEY(Codigo_Transacao)
)

CREATE PROCEDURE sp_transacao(@codigo CHAR(1), @codigo_transacao INT, @codigo_produto INT, @quantidade INT, @valor_total DECIMAL(7,2))
AS
	DECLARE @tabela VARCHAR(8)
	DECLARE @query VARCHAR(MAX)
	DECLARE @erro VARCHAR(MAX)
	IF (@codigo = 'e')
		BEGIN
			SET @tabela = 'entrada'
		END
	ELSE
		BEGIN 
		IF (@codigo = 's')
			BEGIN 
				SET @tabela = 'saida'
			END
		ELSE 
			BEGIN 
				RAISERROR('Codigo de transacao invalido', 16, 1)
			END
		END
	SET @query = 'INSERT INTO '+@tabela+' VALUES ('+CAST(@codigo_transacao AS VARCHAR(5))+','+CAST(@codigo_produto AS VARCHAR(5))+','+
				CAST(@quantidade AS VARCHAR(5))+','+CAST(@valor_total AS VARCHAR(7))+')'
	BEGIN TRY
		EXEC (@query)
	END TRY
	BEGIN CATCH
		SET @erro = ERROR_MESSAGE()
		IF (@erro LIKE '%primary%')
			BEGIN
				RAISERROR('Chave primaria duplicada', 16, 1)
			END
		ELSE
			BEGIN
				RAISERROR('Erro de processamento', 16, 1) 
			END
	END CATCH
	
EXEC sp_transacao 's', 43, 69, 4, 420.69
EXEC sp_transacao 'e', 45, 73, 6, 1337.69
EXEC sp_transacao 'p', 46, 98, 3, 69.42

SELECT * FROM entrada
SELECT * FROM saida