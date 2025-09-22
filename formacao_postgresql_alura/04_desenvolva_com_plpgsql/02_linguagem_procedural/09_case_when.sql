CREATE OR REPLACE FUNCTION status_salario(instrutor instrutor) RETURNS VARCHAR AS $$
    BEGIN
        CASE
            WHEN instrutor.salario = 100 THEN
                RETURN 'Salário muito baixo';
            WHEN instrutor.salario = 200 THEN
                RETURN 'Salário baixo';
            WHEN instrutor.salario = 300 THEN
                RETURN 'Salário ok';
            ELSE
                RETURN 'Bom salário';
        END CASE;
    END
$$ LANGUAGE PLPGSQL;

SELECT
    nome,
    status_salario(instrutor)
FROM instrutor

-- Sintáxe melhor -> colocando do lado do CASE o que quero comparar
CREATE OR REPLACE FUNCTION status_salario(instrutor instrutor) RETURNS VARCHAR AS $$
    BEGIN
        CASE instutor.salario
            WHEN 100 THEN
                RETURN 'Salário muito baixo';
            WHEN 200 THEN
                RETURN 'Salário baixo';
            WHEN 300 THEN
                RETURN 'Salário ok';
            ELSE
                RETURN 'Bom salário';
        END CASE;
    END
$$ LANGUAGE PLPGSQL;
