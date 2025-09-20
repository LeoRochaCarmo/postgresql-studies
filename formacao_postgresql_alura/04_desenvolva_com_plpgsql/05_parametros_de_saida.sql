
-- Como retornar dois valores ou mais em uma função???

-- Forma 1 -> Criando verbosamente um tipo para usar como retorno da função (melhor prática)
CREATE TYPE dois_valores AS (
    soma INTEGER,
    produto INTEGER
);

CREATE FUNCTION soma_e_produto_com_type(numero_1 INTEGER, numero_2 INTEGER)
    RETURNS dois_valores
    AS $$

    SELECT 
        numero_1 + numero_2 AS soma, 
        numero_1 * numero_2 AS produto;

    $$ LANGUAGE SQL;

SELECT * FROM soma_e_produto_com_type(5, 2)

-- Forma 2 -> Usando OUT
CREATE FUNCTION soma_e_produto(
    numero_1 INTEGER, numero_2 INTEGER, 
    OUT soma INTEGER, OUT produto INTEGER) 
    
    AS $$
    
    SELECT 
        numero_1 + numero_2 AS soma, 
        numero_1 * numero_2 AS produto;

    $$ LANGUAGE SQL;

SELECT * FROM soma_e_produto(7, 2);

-- Usando tipo RECORD -> Usado quando colunas e tipos não são conhecidos
CREATE FUNCTION instrutores_bem_pagos(
    valor_salario DECIMAL, OUT nome VARCHAR,
    OUT salario DECIMAL) 
    
    RETURNS SETOF RECORD
    AS $$

    SELECT
        nome,
        salario
    FROM instrutor
    WHERE salario > valor_salario;

    $$ LANGUAGE SQL;

SELECT * FROM instrutores_bem_pagos(100)


