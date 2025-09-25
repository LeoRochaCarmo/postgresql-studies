CREATE FUNCTION instrutores_internos(id_instrutor INTEGER) RETURNS refcursor AS $$
    DECLARE
        cursor_salarios refcursor;
        -- cursor_salarios CURSOR FOR SELECT instrutor.salario FROM instrutor WHERE id <> id_instrutor AND salario > 0;
        salario DECIMAL;
    BEGIN
        -- abertura do cursor
        OPEN cursor_salarios FOR 
            SELECT instrutor.salario 
            FROM instrutor 
            WHERE id <> id_instrutor AND salario > 0;
        
        /*
        -- manipulação do cursor
        FETCH cursor_salario INTO salario;
        FETCH LAST FROM cursor_salario INTO salario; -- pegando último salário
        FETCH NEXT FROM cursor_salario INTO salario; -- NEXT é o padrão
        FETCH PRIOR FROM cursor_salario INTO salario; -- pegando salário anterior
        FETCH FIRST FROM cursor_salario INTO salario; -- pegando primeiro salário

        MOVE LAST FROM cursor_salarios; -- move o ponteiro mas não busca nenhum valor
        */
        
        RETURN cursor_salarios
    END;
$$ LANGUAGE PLPGSQL;