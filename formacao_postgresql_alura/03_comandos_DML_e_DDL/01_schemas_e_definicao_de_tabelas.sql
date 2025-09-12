CREATE SCHEMA academico

DROP TABLE aluno, categoria, curso, aluno_curso CASCADE; 

CREATE TABLE IF NOT EXISTS academico.aluno (
    id SERIAL PRIMARY KEY,
    primeiro_nome VARCHAR(255) NOT NULL CHECK(primeiro_nome <> ''),
    ultimo_nome VARCHAR(255) NOT NULL CHECK(ultimo_nome <> ''),
    data_nascimento DATE NOT NULL DEFAULT NOW()::DATE
);

CREATE TABLE academico.categoria (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE academico.curso (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    categoria_id INTEGER NOT NULL REFERENCES academico.categoria(id)
);


CREATE TABLE academico.aluno_curso (
    aluno_id INTEGER NOT NULL REFERENCES academico.aluno(id),
    curso_id INTEGER NOT NULL REFERENCES academico.curso(id),
    PRIMARY KEY(aluno_id, curso_id)
)

-- DROP TABLE academico.aluno, academico.categoria, academico.curso, academico.aluno_curso CASCADE; 

INSERT INTO academico.aluno (primeiro_nome, ultimo_nome) VALUES('Leo', 'Rocha')

SELECT *
FROM academico.aluno