CREATE TABLE a (nome VARCHAR(255) NOT NULL);

-- O retorno de uma função será o primeiro item do último comando.
-- OR REPLACE -> evita ter que fazer DROP da função quando algo for modificado.
-- Quando quero alterar uma função, não posso alterar os tipos de parâmetros.
-- e tipos de retorno. É necessário fazer um DROP da função e criá-la de novo.
-- $$ -> usados como delimitadores para substituir aspas simples.
CREATE OR REPLACE FUNCTION cria_a (nome VARCHAR) RETURNS VARCHAR AS $$
    INSERT INTO a (nome) VALUES (cria_a.nome);

    SELECT nome;
$$ LANGUAGE SQL;

SELECT cria_a('Leonardo')

SELECT * FROM a