
-- Verificar  quantos instrutores recebem menos que um instrutor específico
DO $$

    DECLARE
        cursor_salarios refcursor;
        salario DECIMAL;
        total_instrutores INTEGER DEFAULT 0;
        instrutores_recebem_menos INTEGER DEFAULT 0;
        id_instrutor INTEGER DEFAULT 12;
        salario_instrutor DECIMAL;
        percentual DECIMAL(5, 2);

    BEGIN
        SELECT instrutores_internos(id_instrutor) INTO cursor_salarios;
        
        SELECT instrutor.salario FROM instrutor WHERE id = id_instrutor INTO salario_instrutor;
            IF NOT FOUND THEN
                RAISE EXCEPTION 'Instrutor não existe.';
            END IF;
    LOOP
        FETCH cursor_salarios INTO salario;
        EXIT WHEN NOT FOUND;
        total_instrutores := total_instrutores + 1;

        IF  salario_instrutor > salario THEN
            instrutores_recebem_menos := instrutores_recebem_menos + 1;
        END IF;
    END LOOP;

    percentual = instrutores_recebem_menos::DECIMAL / total_instrutores::DECIMAL * 100;
    RAISE NOTICE '% %% recebem menos que o instrutor de id %.', percentual, id_instrutor;
    
    END;

$$;

SELECT * FROM instrutor;