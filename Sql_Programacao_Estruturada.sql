/* Fazer um algoritmo que leia 3 valores e retorne se os valores formam um triângulo e se ele é isóceles, escaleno ou equilátero. 
Condições para formar um triângulo Nenhum valor pode ser = 0, Um lado não pode ser maior que a soma dos outros 2.
*/
DECLARE @ladoUm  INT 
DECLARE	@ladoDois INT
DECLARE	@ladoTres INT

SET @ladoUm = 2
SET @ladoDois = 3
SET @ladoTres = 2

IF (@ladoUm = 0 OR @ladoDois = 0 OR @ladoTres = 0)
BEGIN
	PRINT 'NAO ATENDE AS REGRAS PARA SER TRIANGULO'
END
ELSE
BEGIN
		IF (	(@ladoUm > @ladoDois + @ladoTres) OR (@ladoDois > @ladoUm + @ladoTres) OR (@ladoTres = @ladoDois + @ladoUm)	)
		BEGIN
			PRINT 'NAO ATENDE AS REGRAS PARA SER TRIANGULO'
		END
		ELSE
		BEGIN
			IF (@ladoUm != @ladoDois AND @ladoUm != @ladoTres AND @ladoTres != @ladoDois)
			BEGIN
				PRINT 'TRIANGULO ESCALENO'
			END
			ELSE
			BEGIN
				IF (@ladoUm = @ladoDois AND @ladoUm = @ladoTres)
				BEGIN
					PRINT 'TRIANGULO EQUILATERO'
				END
				ELSE
					PRINT 'TRIANGULO ISOCELES'
				END
		END
END

 -- Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
DECLARE @numero INT 
SET @numero = 7

IF (@numero % 2 = 0)
BEGIN
	PRINT 'o numero é multiplo de 2'
END
	IF(@numero % 3 = 0)
	BEGIN
		PRINT 'o numero é multiplo de 3'
	END
		IF(@numero % 5 = 0)
		BEGIN
			PRINT 'o numero é multiplo de 5'
		END
		ELSE
		BEGIN
			PRINT 'nao é multiplo de nenhum deles'
		END

-- Fazer um algoritmo que leia 3 número e mostre o maior e o menor
DECLARE @numUM INT
DECLARE @numDois INT
DECLARE @numTres INT
DECLARE @maior INT
DECLARE @menor INT

SET @numUM = 4
SET @numDois = 7
SET @numTres = 1

IF (@numUM > @numDois)
BEGIN
	SET	@maior = @numUM
	SET @menor = @numDois

	IF (@maior < @numTres)
	BEGIN
		SET @maior = @numTres
	END

	IF (@menor > @numTres)
	BEGIN
		SET @menor = @numTres
	END

	PRINT @maior
	PRINT @menor

END
ELSE
BEGIN
	SET	@menor = @numUM
	SET @maior = @numDois
	
	IF (@maior < @numTres)
	BEGIN
		SET @maior = @numTres
	END

	IF (@menor > @numTres)
	BEGIN
		SET @menor = @numTres
	END

	PRINT @maior
	PRINT @menor

END

/*
Fazer um algoritmo que calcule os 15 primeiros termos da série 1,1,2,3,5,8,13,21,... E calcule a soma dos 15 termos
*/

DECLARE @termoUm INT
DECLARE @termoDois INT
DECLARE @contador INT
DECLARE @aux INT
DECLARE @soma INT

SET @termoUm = 0
SET @termoDois = 1
SET @contador = 1
SET @soma = 0

WHILE (@contador <= 15)
BEGIN

	SET @soma = @soma + @termoDois
	SET @aux = @termoUm + @termoDois
	SET @termoUm = @termoDois
	SET @termoDois = @aux
	SET @contador = @contador + 1

END

	PRINT 'a soma é: ' + CAST(@soma as varchar(4)) 

-- Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em minúsculo

DECLARE @frase VARCHAR(15)
DECLARE @novaFrase VARCHAR(15)
DECLARE @letra char(1)
DECLARE @contadorN INT
DECLARE @tamanho INT

SET @frase = 'ola mundo'
SET @contadorN = 0
SET @tamanho = LEN(@frase)

WHILE (@contadorN <= @tamanho)
BEGIN

	SET @contadorN = @contadorN + 1

	IF (@contadorN % 2 = 0)
	BEGIN
		SET @letra = SUBSTRING(@frase,  @contadorN, 1)
	END
	ELSE
	BEGIN
		SET @letra = UPPER(SUBSTRING(@frase,@contadorN , 1))
	END

	SET @novaFrase = concat(@novaFrase, @letra)

END

	PRINT @novaFrase 
	

-- Fazer um algoritmo que inverta uma palavra
DECLARE @frase2 VARCHAR(15)
DECLARE @novaFrase2 VARCHAR(15)
DECLARE @letra2 char(1)
DECLARE @contadorN2 INT
DECLARE @tamanho2 INT

SET @frase2 = 'ola mundo'
SET @tamanho2 = LEN(@frase2)
SET @contadorN2 = @tamanho2


WHILE (@contadorN2 >= 0)
BEGIN

	SET @letra2 = SUBSTRING(@frase2,  @contadorN2, 1)
	SET @novaFrase2 = concat(@novaFrase2, @letra2)
	SET @contadorN2 = @contadorN2 - 1

END

	PRINT @novaFrase2

-- Verificar palindromo
DECLARE @frase3 VARCHAR(15)
DECLARE @novaFrase3 VARCHAR(15)
DECLARE @letra3 char(1)
DECLARE @contadorN3 INT
DECLARE @tamanho3 INT

SET @frase3 = 'subi no onibus'
SET @tamanho3 = LEN(@frase3)
SET @contadorN3 = @tamanho3


WHILE (@contadorN3 >= 0)
BEGIN

	SET @letra3 = SUBSTRING(@frase3,  @contadorN3, 1)
	SET @novaFrase3 = concat(@novaFrase3, @letra3)
	SET @contadorN3 = @contadorN3 - 1

END

	SET @novaFrase3 = REPLACE(@novaFrase3,' ','')
	SET @frase3 = REPLACE(@frase3,' ','')

	print @novaFrase3
	print @frase3

	IF (@frase3 = @novaFrase3)
	BEGIN
		PRINT 'É um palindromo'
	END
	ELSE
	BEGIN 
		PRINT 'Nao é um palindromo'
	END

DECLARE @cpf  CHAR(11)
DECLARE @numero INT
DECLARE	@soma INT
DECLARE @resto INT

DECLARE	@digitoUm INT
DECLARE	@digitoDois INT

DECLARE @cont INT
DECLARE @contDigUm INT
DECLARE @contDigDois INT

SET @cont = 1
SET @soma = 0
SET @contDigUm = 10
SET @contDigDois = 11
SET @cpf = '22233366638'

-------------------- valida se todos os numeros sao iguais -----------------------

DECLARE @novoCont INT
DECLARE @outroValor INT
DECLARE @contValida INT

SET @novoCont = 1
SET @contValida = 1
SET @outroValor = CAST(SUBSTRING(@cpf,1, 1) as int)

WHILE (@novoCont <= 10)
BEGIN
	SET @novoCont = @novoCont + 1

	IF(@outroValor = CAST(SUBSTRING(@CPF, @novoCont, 1) as INT))
	BEGIN
		SET @contValida = @contValida + 1
	END
	
END

IF (@contValida = 11)
BEGIN
	PRINT 'Esse numero nao é valido, pois é todo igual'
	set noexec on
END








---------------------- Validacao dos digitos de cpf -----------------------
WHILE (@cont <= 9)
BEGIN
	SET @numero = CAST(SUBSTRING(@cpf,  @cont, 1) as INT)
	SET @soma = @soma + (@numero * @contDigUm)
	SET @contDigUm = @contDigUm - 1
	SET @cont = @cont + 1
END

SET @resto = @soma % 11
SET @digitoUm = CAST(SUBSTRING(@cpf, 10, 1) as INT)

IF(@resto < 2)
BEGIN
	IF(@digitoUm = 0)
	BEGIN
		PRINT 'O digito um é valido'
	END
END
ELSE
BEGIN
	IF(@digitoUm = (11 - @resto))
	BEGIN
		 PRINT 'O digito um é valido'
	END
	ELSE
	BEGIN
		PRINT 'O primeiro digito não é valido'
	END
END

SET @cont = 1
SET @soma = 0
SET @resto = 0

WHILE (@cont <= 10)
BEGIN
	SET @numero = CAST(SUBSTRING(@cpf,  @cont, 1) as INT)
	SET @soma = @soma + (@numero * @contDigDois)
	SET @contDigDois = @contDigDois - 1
	SET @cont = @cont + 1
END

SET @resto = @soma % 11
SET @digitoDois = CAST(SUBSTRING(@cpf, 11, 1) as INT)

IF(@resto < 2)
BEGIN
	IF(@digitoDois = 0)
	BEGIN
		PRINT 'O digito dois é valido'
	END
END
ELSE
BEGIN
	IF(@digitoDois = (11 - @resto))
	BEGIN
		 PRINT 'O digito dois é valido'
	END
	ELSE
	BEGIN
		PRINT 'O digito dois não é valido'
	END
END

set noexec off