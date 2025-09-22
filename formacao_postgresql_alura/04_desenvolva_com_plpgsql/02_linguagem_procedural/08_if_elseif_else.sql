-- Função que retorna um texto dizendo se o salário está ok ou não
CREATE OR REPLACE FUNCTION status_salario(instrutor instrutor) RETURNS VARCHAR AS $$
    
    BEGIN

        IF instrutor.salario >= 150 THEN 
            RETURN 'Salário está ok';
        ELSE 
            RETURN 'Salário pode aumentar';
        END IF;

    END;

$$ LANGUAGE PLPGSQL

SELECT
    nome,
    status_salario(instrutor) FROM instrutor

-- Outra abordagem -> Passando apenas o id de um instrutor
-- Essa abordagem é menos performática
DROP FUNCTION status_salario;
CREATE OR REPLACE FUNCTION status_salario(id_instrutor INTEGER) RETURNS VARCHAR AS $$
    DECLARE
        instrutor instrutor;
    BEGIN
        SELECT * FROM instrutor WHERE id = id_instrutor INTO instrutor;
        IF instrutor.salario >= 150 THEN 
            RETURN 'Salário está ok';
        ELSE 
            RETURN 'Salário pode aumentar';
        END IF;

    END;

$$ LANGUAGE PLPGSQL

SELECT
    nome,
    status_salario(instrutor.id) FROM instrutor

-- Usando ELSEIF para mais de 2 condições
CREATE OR REPLACE FUNCTION status_salario(instrutor instrutor) RETURNS VARCHAR AS $$
    BEGIN
        IF instrutor.salario > 200 THEN
            RETURN 'Salário está ok';
        ELSEIF instrutor.salario = 200 THEN
            RETURN 'Salário pode aumentar';
        ELSE
            RETURN 'Salário está defasado';
        END IF;
    END
$$ LANGUAGE PLPGSQL

SELECT
    nome,
    status_salario(instrutor)
FROM instrutor
