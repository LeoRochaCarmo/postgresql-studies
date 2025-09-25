DROP TRIGGER cria_log_instrutores ON instrutor;

CREATE TRIGGER cria_log_instrutores BEFORE INSERT ON instrutor
    FOR EACH ROW EXECUTE FUNCTION inserir_instrutor();

CREATE OR REPLACE FUNCTION inserir_instrutor() RETURNS TRIGGER AS $$
    DECLARE
        media_salarial DECIMAL;
        porcentagem DECIMAL(5,2);
    BEGIN
        SELECT AVG(salario) FROM instrutor WHERE id <> NEW.id INTO media_salarial;
        SELECT 100.0 * COUNT(*) FILTER(WHERE salario < NEW.salario AND id <> NEW.id) / COUNT(*) FROM instrutor INTO porcentagem;

        -- ASSERT -> Lançar exceções em apenas uma linha
        ASSERT porcentagem < 100, 'Salário fora do teto salarial';

        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores(informacao) VALUES(FORMAT('Salário de %1$s é maior do que a média', NEW.nome));
        END IF;
        
        INSERT INTO log_instrutores(informacao) VALUES(FORMAT('%1$s recebe mais do que %2$s%% da grade de instrutores', NEW.nome, porcentagem));

        RETURN NEW;
    END;

$$ LANGUAGE PLPGSQL;

SELECT MAX(salario) FROM instrutor;

INSERT INTO instrutor(nome, salario) VALUES('Ricão', 2000);