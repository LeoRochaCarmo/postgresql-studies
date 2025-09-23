/*
 
 - Inserir instrutores (com salários).
 - Se o salário for maior do que a média, salvar um log.
 - Salvar outro log dizendo que fulano recebe mais do que X% da grade de instrutores
 
 */

 CREATE TABLE log_instrutores(
    id SERIAL PRIMARY KEY,
    informacao VARCHAR(255),
    momento_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
 );

DROP FUNCTION inserir_instrutor;

-- Minha resolução
CREATE OR REPLACE FUNCTION inserir_instrutor(nome_instrutor VARCHAR, salario_instrutor DECIMAL) RETURNS void AS $$
    DECLARE
        media_salarial DECIMAL;
        porcentagem INTEGER;
        id_instrutor_inserido INTEGER;
    BEGIN
        INSERT INTO instrutor (nome, salario) VALUES(nome_instrutor, salario_instrutor) RETURNING id INTO id_instrutor_inserido;
        SELECT AVG(salario) FROM instrutor WHERE id <> id_instrutor_inserido INTO media_salarial;
        SELECT ROUND(100.0 * COUNT(*) FILTER(WHERE salario < salario_instrutor AND id <> id_instrutor_inserido) / COUNT(*), 2) FROM instrutor INTO porcentagem;

        IF salario_instrutor > media_salarial THEN
            INSERT INTO log_instrutores(informacao) VALUES(FORMAT('Salário de %1$s é maior do que a média', nome_instrutor));
        END IF;
        
        INSERT INTO log_instrutores(informacao) VALUES(FORMAT('%1$s recebe mais do que %2$s%% da grade de instrutores', nome_instrutor, porcentagem));

    END;

$$ LANGUAGE PLPGSQL;

-- Resolução do instrutor
CREATE OR REPLACE FUNCTION inserir_instrutor(nome_instrutor VARCHAR, salario_instrutor DECIMAL) RETURNS void AS $$
    DECLARE
        media_salarial DECIMAL;
        porcentagem INTEGER;
        id_instrutor_inserido INTEGER;
        instrutores_recebem_menos INTEGER DEFAULT 0;
        total_instrutores INTEGER DEFAULT 0;
        salario DECIMAL;

    BEGIN
        INSERT INTO instrutor (nome, salario) VALUES(nome_instrutor, salario_instrutor) RETURNING id INTO id_instrutor_inserido;
        SELECT AVG(instrutor.salario) FROM instrutor INTO media_salarial WHERE id <> id_instrutor_inserido;

        FOR salario IN SELECT instrutor.salario FROM instrutor WHERE id <> id_instrutor_inserido LOOP
            total_instrutores := total_instrutores + 1;

            IF salario_instrutor > salario THEN
                instrutores_recebem_menos := instrutores_recebem_menos + 1;
            END IF;

        END LOOP;

        porcentagem := ROUND(instrutores_recebem_menos / total_instrutores * 100.0, 2);

        IF salario_instrutor > media_salarial THEN
            INSERT INTO log_instrutores(informacao) VALUES(FORMAT('Salário de %1$s é maior do que a média', nome_instrutor));
        END IF;
        
        INSERT INTO log_instrutores(informacao) VALUES(FORMAT('%1$s recebe mais do que %2$s%% da grade de instrutores', nome_instrutor, porcentagem));

    END;

$$ LANGUAGE PLPGSQL;
SELECT inserir_instrutor('Patrick', 318.50);

SELECT AVG(salario) FROM instrutor

SELECT * FROM log_instrutores

SELECT * FROM instrutor