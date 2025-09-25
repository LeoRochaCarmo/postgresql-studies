DROP TRIGGER cria_log_instrutores ON instrutor;

CREATE TRIGGER cria_log_instrutores BEFORE INSERT ON instrutor
    FOR EACH ROW EXECUTE FUNCTION inserir_instrutor();

CREATE OR REPLACE FUNCTION inserir_instrutor() RETURNS TRIGGER AS $$
    DECLARE
        media_salarial DECIMAL;
        porcentagem DECIMAL(5,2);
        logs_inseridos INTEGER;
        salario DECIMAL;
    BEGIN
        SELECT AVG(instrutor.salario) FROM instrutor WHERE id <> NEW.id INTO media_salarial;
        SELECT 100.0 * COUNT(*) FILTER(WHERE instrutor.salario < NEW.salario AND id <> NEW.id) / COUNT(*) FROM instrutor INTO porcentagem;

        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores(informacao) VALUES(FORMAT('Salário de %1$s é maior do que a média', NEW.nome));
            -- Forma de recuperar informações sobre a execução da instrução SQL
            -- ROW_COUNT -> número de linhas afetadas
            GET DIAGNOSTICS logs_inseridos = ROW_COUNT;
        END IF;

        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> NEW.id LOOP
            -- Exibição de mensagem para depurar uma execução
            RAISE NOTICE 'Salario inserido: % Salário do instrutor existente: %', NEW.salario, salario;
        END LOOP;
        
        INSERT INTO log_instrutores(informacao) VALUES(FORMAT('%1$s recebe mais do que %2$s%% da grade de instrutores', NEW.nome, porcentagem));

        RETURN NEW;
    END;

$$ LANGUAGE PLPGSQL;

INSERT INTO instrutor(nome, salario) VALUES('Riquinho', 1500);

SELECT salario FROM instrutor;