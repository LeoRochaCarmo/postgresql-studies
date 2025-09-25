
-- Criação de uma trigger
CREATE TRIGGER cria_log_instrutores AFTER INSERT ON instrutor
    FOR EACH ROW EXECUTE FUNCTION inserir_instrutor();


SELECT * FROM instrutor;

SELECT AVG(salario) FROM instrutor;

SELECT * FROM log_instrutores;

INSERT INTO instrutor (nome, salario) VALUES('Ester', 320);
INSERT INTO instrutor (nome, salario) VALUES('Caio', 310);