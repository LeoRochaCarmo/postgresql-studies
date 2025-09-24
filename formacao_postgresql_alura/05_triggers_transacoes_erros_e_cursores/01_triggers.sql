DROP FUNCTION inserir_instrutor;

-- Função recriada como Trigger Procedure
CREATE OR REPLACE FUNCTION inserir_instrutor() RETURNS TRIGGER AS $$
    DECLARE
        media_salarial DECIMAL;
        porcentagem DECIMAL(5,2);
    BEGIN
        SELECT AVG(salario) FROM instrutor WHERE id <> NEW.id INTO media_salarial;
        SELECT 100.0 * COUNT(*) FILTER(WHERE salario < NEW.salario AND id <> NEW.id) / COUNT(*) FROM instrutor INTO porcentagem;

        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores(informacao) VALUES(FORMAT('Salário de %1$s é maior do que a média', NEW.nome));
        END IF;
        
        INSERT INTO log_instrutores(informacao) VALUES(FORMAT('%1$s recebe mais do que %2$s%% da grade de instrutores', NEW.nome, porcentagem));

    END;

$$ LANGUAGE PLPGSQL;

INSERT INTO instrutor (nome, salario) VALUES(nome_instrutor, salario_instrutor) RETURNING id INTO id_instrutor_inserido;