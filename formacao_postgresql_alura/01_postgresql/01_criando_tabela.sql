CREATE TABLE IF NOT EXISTS aluno (
    id serial,
    nome VARCHAR(255),
    cpf CHAR(11),
    observacao TEXT,
    idade INTEGER,
    dinheiro numeric(10,2),
    altura real,
    ativo BOOLEAN,
    data_nascimento DATE,
    hora_aula TIME,
    data_matricula TIMESTAMP
);

SELECT *
FROM aluno
