/*
    Desafio -> Se o instrutor receber mais do que 100% da base, 
    você vai buscar o maior salário com o select, 
    e esse maior salário você vai atribuir a esse instrutor que está sendo inserido.
*/

-- Modificando a função
CREATE OR REPLACE FUNCTION inserir_instrutor() RETURNS TRIGGER AS $$
    DECLARE
        media_salarial DECIMAL;
        porcentagem DECIMAL(5,2);
        maior_salario DECIMAL;
    BEGIN
        SELECT AVG(salario) FROM instrutor WHERE id <> NEW.id INTO media_salarial;
        SELECT 100.0 * COUNT(*) FILTER(WHERE salario < NEW.salario AND id <> NEW.id) / COUNT(*) FROM instrutor INTO porcentagem;
        SELECT MAX(salario) FROM instrutor WHERE id <> NEW.id INTO maior_salario;

        IF NEW.salario > media_salarial THEN
            INSERT INTO log_instrutores(informacao) VALUES(FORMAT('Salário de %1$s é maior do que a média', NEW.nome));
        END IF;
        
        -- Modificação do valor de salário se porcentagem maior ou igual a 100
        IF porcentagem >= 100.0 THEN
            NEW.salario = maior_salario;
        END IF;

        INSERT INTO log_instrutores(informacao) VALUES(FORMAT('%1$s recebe mais do que %2$s%% da grade de instrutores', NEW.nome, porcentagem));

        RETURN NEW;
    END;

$$ LANGUAGE PLPGSQL;

-- Removendo Trigger
DROP TRIGGER cria_log_instrutores ON instrutor;

-- Alterando Trigger com BEFORE
CREATE TRIGGER cria_log_instrutores BEFORE INSERT ON instrutor
    FOR EACH ROW EXECUTE FUNCTION inserir_instrutor();

INSERT INTO instrutor(nome, salario) VALUES('Muito rico', 5000);
INSERT INTO instrutor(nome, salario) VALUES('Quase Rico', 999);

SELECT * FROM instrutor;

SELECT * FROM log_instrutores;