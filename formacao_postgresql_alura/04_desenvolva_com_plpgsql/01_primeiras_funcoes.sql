CREATE FUNCTION primeira_funcao() RETURNS INTEGER AS '
    SELECT (5-3) * 2
' LANGUAGE SQL;

SELECT * FROM primeira_funcao() AS numero


CREATE Function soma_dois_numeros(numero_1 INTEGER, numero_2 INTEGER) RETURNS INTEGER AS '
    SELECT numero_1 + numero_2
' LANGUAGE SQL;

SELECT soma_dois_numeros(2, 2);

CREATE FUNCTION multiplicacao(a INTEGER, b INTEGER) RETURNS INTEGER
LANGUAGE SQL
RETURN a + b;

SELECT * FROM multiplicacao(2, 4)