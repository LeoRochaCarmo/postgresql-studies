-- Criando multiplicado que começa do 1 e vai até 9

CREATE OR REPLACE FUNCTION tabuada(numero INTEGER) RETURNS SETOF VARCHAR AS $$
    DECLARE
        multiplicador INTEGER DEFAULT 1;
    BEGIN
        LOOP
            -- RETURN NEXT numero || ' x ' || multiplicador || ' = ' || (numero * multiplicador); OUTRA FORMA
            RETURN NEXT FORMAT('%s x %s = %s', numero, multiplicador, (numero * multiplicador));
            multiplicador := multiplicador + 1;
            EXIT WHEN multiplicador > 9;
        END LOOP;
    END;

$$ LANGUAGE PLPGSQL

SELECT * FROM tabuada(5)

