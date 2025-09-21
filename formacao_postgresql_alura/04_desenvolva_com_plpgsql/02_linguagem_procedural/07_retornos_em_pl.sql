-- Reescrevendo funções com PL/pgSQL

CREATE FUNCTION primeira_funcao() RETURNS INTEGER AS $$

    BEGIN
        RETURN 1;
    END

$$ LANGUAGE PLPGSQL;

-- Retornando tipo composto (FORMA 1)
DROP FUNCTION criar_instrutor_falso;
CREATE OR REPLACE FUNCTION criar_instrutor_falso() RETURNS instrutor AS $$
    BEGIN
        -- Preciso informar o tipo dessa linha
        RETURN (1, 'Caio', 150)::instrutor;
    END
$$ LANGUAGE PLPGSQL;

SELECT * FROM criar_instrutor_falso()

-- Retornando tipo composto (FORMA 2)
CREATE OR REPLACE FUNCTION criar_instrutor_falso() RETURNS instrutor AS $$
    DECLARE
        retorno instrutor;
    BEGIN
        SELECT 1, 'Caio', 150::DECIMAL INTO retorno;

        RETURN retorno;
    END
$$ LANGUAGE PLPGSQL;

SELECT * FROM criar_instrutor_falso()

-- Retornando conjuntos com RETURN QUERY para consultas
DROP FUNCTION instrutores_bem_pagos;
CREATE OR REPLACE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF instrutor AS $$
    BEGIN
        RETURN QUERY
        SELECT * FROM instrutor WHERE salario > valor_salario;
        -- Esse RETURN pode ser omitido
        RETURN;
    END
$$ LANGUAGE PLPGSQL

SELECT * FROM instrutores_bem_pagos(100);

-- Retornando só nome e salário
CREATE TYPE nome_e_salario AS(
    nome VARCHAR(255),
    salario DECIMAL(10,2)
    );

DROP FUNCTION instrutores_bem_pagos;

CREATE OR REPLACE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF nome_e_salario AS $$
    BEGIN
        RETURN QUERY
        SELECT nome, salario FROM instrutor WHERE salario > valor_salario;
        -- Esse RETURN pode ser omitido
        RETURN;
    END
$$ LANGUAGE PLPGSQL

SELECT * FROM instrutores_bem_pagos(100);
