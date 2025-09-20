-- Sintaxe de uma função
CREATE FUNCTION primeira_funcao() RETURNS INTEGER AS '
    SELECT (5-3) * 2
' LANGUAGE SQL;

SELECT * FROM primeira_funcao() AS numero

-- Recebendo parâmetros com nomes definidos (melhor prática)
CREATE FUNCTION soma_dois_numeros(numero_1 INTEGER, numero_2 INTEGER) RETURNS INTEGER AS '
    SELECT numero_1 + numero_2
' LANGUAGE SQL;

SELECT soma_dois_numeros(2, 2);

-- Recebendo parâmetros com nomes não definidos
-- $ -> para indicar a posição do parâmetro
CREATE FUNCTION divide_dois_numeros(INTEGER, INTEGER) RETURNS INTEGER AS '
    SELECT $1 / $2 
' LANGUAGE SQL;

SELECT * FROM divide_dois_numeros(4, 2);

-- Usando RETURN no final para simplificar
CREATE FUNCTION multiplicacao(a INTEGER, b INTEGER) RETURNS INTEGER
LANGUAGE SQL
RETURN a + b;

SELECT * FROM multiplicacao(2, 4)

-- Função teste que fiz
CREATE FUNCTION select_year(date DATE) RETURNS INTEGER
LANGUAGE SQL
RETURN EXTRACT(YEAR FROM date);

SELECT * FROM select_year('08-08-1995')