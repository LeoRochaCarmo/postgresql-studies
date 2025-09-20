CREATE TABLE instrutor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    salario DECIMAL(10, 2)
);

INSERT INTO instrutor(nome, salario) VALUES ('Vinicius Dias', 100);
INSERT INTO instrutor(nome, salario) VALUES ('Leo Rocha', 200);
INSERT INTO instrutor(nome, salario) VALUES ('João Vitor', 300);

-- Parâmetros compostos
CREATE FUNCTION dobro_do_salario (instrutor) RETURNS DECIMAL AS $$ 
    SELECT $1.salario * 2 AS dobro;
$$ LANGUAGE SQL;

SELECT
    nome,
    dobro_do_salario(instrutor.*)
FROM instrutor

-- Retornos compostos
CREATE FUNCTION criar_instrutor_falso() RETURNS instrutor AS $$
    SELECT 1, 'Caio', 150
$$ LANGUAGE SQL;

SELECT * FROM criar_instrutor_falso()