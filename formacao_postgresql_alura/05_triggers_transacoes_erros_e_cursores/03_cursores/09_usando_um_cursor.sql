/*
    No PostgreSQL, FOR já usa cursores. Por baixo dos panos, o FOR atribui a query à um cursor,
    vai fazendo FETCH e atribuindo à variável.

    Na prática, os dados vindos da execução da query não estão sendo complematamente armazenados
    em memória para depois serem pegos 1 por 1. O que acontece é que a query é executada linha por linha
    e já atribuindo o valor à uma variável.
*/

CREATE OR REPLACE FUNCTION instrutores_internos(id_instrutor INTEGER) RETURNS refcursor AS $$
    DECLARE
        cursor_salarios refcursor;
        -- cursor_salarios CURSOR FOR SELECT instrutor.salario FROM instrutor WHERE id <> id_instrutor AND salario > 0;
    BEGIN
        -- abertura do cursor
        OPEN cursor_salarios FOR 
            SELECT instrutor.salario 
            FROM instrutor 
            WHERE id <> id_instrutor AND salario > 0;
        
        RETURN cursor_salarios;
    END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION inserir_instrutor() RETURNS TRIGGER AS $$
    DECLARE
        media_salarial DECIMAL;
        instrutores_recebem_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        percentual DECIMAL(5,2);
        cursor_salarios refcursor;
        salario DECIMAL;
    BEGIN
        SELECT AVG(instrutor.salario) FROM instrutor WHERE id <> NEW.id INTO media_salarial;

        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores(informacao) VALUES(FORMAT('Salário de %1$s é maior do que a média', NEW.nome));
        END IF;

        SELECT instrutores_internos(NEW.id) INTO cursor_salarios;
        LOOP
            FETCH cursor_salarios INTO salario;
            EXIT WHEN NOT FOUND;
            total_instrutores := total_instrutores + 1;

            IF NEW.salario > salario THEN
            instrutores_recebem_menos := instrutores_recebem_menos + 1;
            END IF; 
        END LOOP;

        percentual = instrutores_recebem_menos / total_instrutores * 100;
        ASSERT percentual < 100, 'Salário fora do teto salarial';
        
        INSERT INTO log_instrutores(informacao) 
        VALUES(FORMAT('%1$s recebe mais do que %2$s%% da grade de instrutores', NEW.nome, percentual));

        RETURN NEW;
    END;

$$ LANGUAGE PLPGSQL;


INSERT INTO instrutor(nome, salario) VALUES('Cursorvaldo', 132323);