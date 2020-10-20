/*
- Modificar o nome da coluna ano da tabela edicoes, para AnoEdicao
- Modificar o tamanho do varchar do Nome da editora de 50 para 30
- Modificar o tipo da coluna ano da tabela autor para int

- Inserir os dados
- A universidade do Prof. Tannenbaum chama-se Vrije e não Vrij, modificar
- A livraria vendeu 2 unidades do livro 0130661023, atualizar
- Por não ter mais livros do David Halliday, apagar o autor.
*/

CREATE DATABASE livraria
GO
USE livraria

CREATE TABLE livro(
codigo_livro		INT				NOT NULL,
nome				VARCHAR(100)	NULL,
lingua				VARCHAR(50)		NULL,
ano					INT				NULL
PRIMARY KEY(codigo_livro)
)

TRUNCATE TABLE livro

CREATE TABLE autor(
codigo_autor		INT				NOT NULL,
nome				VARCHAR(100)	NULL,
nascimento			DATE			NULL,
pais				VARCHAR(50)		NULL,
biografia			VARCHAR(MAX)	NULL
PRIMARY KEY(codigo_autor)
)

--DROP TABLE livro
--TRUNCATE TABLE autor

CREATE TABLE livro_autor (
livrocodigo_livro	INT				NOT NULL,
autorcodigo_autor	INT				NOT NULL
PRIMARY KEY(livrocodigo_livro, autorcodigo_autor)
FOREIGN KEY (autorcodigo_autor) REFERENCES autor(codigo_autor),
FOREIGN KEY (livrocodigo_livro) REFERENCES livro(codigo_livro)
)

EXEC sp_help autor
EXEC sp_help livro

CREATE TABLE edicoes(
ISBN				INT				NOT NULL,
preco				DECIMAL(7,2)	NULL,
ano					INT				NULL,
num_paginas			INT				NULL,
qtd_estoque			INT				NULL
PRIMARY KEY(ISBN)
)

CREATE TABLE editora(
codigo_editora		INT				NOT NULL,
nome				VARCHAR(50)		NULL,
logradouro			VARCHAR(255)	NULL,
numero				INT				NULL,
cep					CHAR(8)			NULL,
telefone			CHAR(11)		NULL
PRIMARY KEY(codigo_editora)
)

CREATE TABLE livro_edicoes_editora(
ISBN				INT				NOT NULL,
codigo_editora		INT				NOT NULL,
codigo_livro		INT				NOT NULL
PRIMARY KEY(ISBN, codigo_editora, codigo_livro)
FOREIGN KEY(ISBN) REFERENCES edicoes(ISBN),
FOREIGN KEY(codigo_editora) REFERENCES editora(codigo_editora),
FOREIGN KEY(codigo_livro) REFERENCES livro(codigo_livro)
)

--Modificar nome de tabela e coluna
--EXEC sp_rename tabela, novo_nome, 'COLUMN' (3a cláusula só se for coluna)
EXEC sp_rename 'dbo.edicoes.ano','ano_edicao','COLUMN'

--ALTERAR NOME DA COLUNA
ALTER TABLE editora
ALTER COLUMN nome VARCHAR(30) NOT NULL

--PRIMEIRA APAGAR NASCIMENTO
--TROCAR NASCIMENTO PARA ANO E INT
ALTER TABLE autor
DROP COLUMN nascimento

ALTER TABLE autor
ADD ano INT NOT NULL

--INSERIR DADOS
INSERT INTO autor(codigo_autor,nome,ano,pais,biografia)
VALUES
(10001,'Inácio da Silva',1975,'Brasil','Programador WEB desde 1995'),
(10002,'Andrew Tannenbaum',1944,'EUA','Chefe do Departamento de Sistemas de Computação da Universidade de Vrij'),
(10003,'Luis Rocha',1967,'Brasil','Programador Mobile desde 2000'),
(10004,'David Halliday',1916,'EUA','Físico PH.D desde 1941')


INSERT INTO livro(codigo_livro,nome,lingua,ano)
VALUES
(1001,'CCNA 4.1','PT-BR',2015),
(1002,'HTML 5','PT-BR',2017),
(1003,'Redes de Computadores','EN',2010),
(1004,'Android em Ação','PT-BR',2018)

SELECT * FROM autor

SELECT * FROM livro

INSERT INTO livro_autor
VALUES
(1001,10001),
(1002,10003),
(1003,10002),
(1004,10003)

SELECT * FROM livro_autor

INSERT INTO edicoes
VALUES(0130661023,189.99,2018,653,10)

SELECT * FROM edicoes

--FINALIZAÇÃO DA INSERÇÃO DE DADOS DE ACORDO COM OS DIAGRAMAS
UPDATE autor
SET biografia = 'Chefe do Departamento de Sistemas de Computação da Universidade de Vrije'
WHERE codigo_autor = 10002

SELECT * FROM autor

SELECT * FROM edicoes
--TIRAR 2 DO ESTOQUE
UPDATE edicoes
SET qtd_estoque = qtd_estoque - 2
WHERE ISBN = 0130661023

SELECT * FROM edicoes

--APAGAR DAVID HALLIDAY DA EXISTENCIA DA TABELA
DELETE autor
WHERE codigo_autor = 10004
SELECT * FROM autor