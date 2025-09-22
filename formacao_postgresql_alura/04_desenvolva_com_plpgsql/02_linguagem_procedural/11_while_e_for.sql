-- Uso do WHILE -> Melhor quando o número de iterações é desconhecido e depende de uma condição
DROP FUNCTION tabuada;
CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
    DECLARE
        multiplicador INTEGER DEFAULT 1;
    BEGIN
        WHILE multiplicador < 10 LOOP
            RETURN NEXT FORMAT('%s x %s = %s', numero, multiplicador, (numero * multiplicador));
            multiplicador := multiplicador + 1;
        END LOOP;
    END;

$$ LANGUAGE PLPGSQL

SELECT * FROM tabuada(5)

-- Uso do FOR -> Melhor quando o número repetições é limitado
DROP FUNCTION tabuada;
CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
    BEGIN
        FOR multiplicador IN 1..9 LOOP
            RETURN NEXT FORMAT('%s x %s = %s', numero, multiplicador, (numero * multiplicador));
            multiplicador := multiplicador + 1;
        END LOOP;
    END;

$$ LANGUAGE PLPGSQL

SELECT * FROM tabuada(5)

-- Usando FOR em uma query
CREATE OR REPLACE FUNCTION instrutor_com_salario(OUT nome VARCHAR, OUT status_salario VARCHAR) RETURNS SETOF record AS $$
    DECLARE
        instrutor instrutor;
    BEGIN
        FOR instrutor IN SELECT * FROM instrutor LOOP
            nome := instrutor.nome;
            status_salario = status_salario(instrutor);

            RETURN NEXT;
        END LOOP;
    END;
$$ LANGUAGE PLPGSQL


SELECT * FROM instrutor_com_salario();