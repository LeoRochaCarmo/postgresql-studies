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

INSERT INTO academico.aluno (primeiro_nome, ultimo_nome, data_nascimento) VALUES 
    ('Vinicius', 'Dias', '1997-10-15'), 
    ('Patricia', 'Freitas', '1986-10-25'), 
    ('Diogo', 'Oliveira', '1984-08-27'), 
    ('Maria', 'Rosa', '1985-01-01');

INSERT INTO academico.categoria (nome) VALUES ('Front-end'), ('Programação'), ('Bancos de dados'), ('Data Science');

INSERT INTO academico.curso (nome, categoria_id) VALUES
    ('HTML', 1),
    ('CSS', 1),
    ('JS', 1),
    ('PHP', 2),
    ('Java', 2),
    ('C++', 2),
    ('PostgreSQL', 3),
    ('MySQL', 3),
    ('Oracle', 3),
    ('SQL Server', 3),
    ('SQLite', 3),
    ('Pandas', 4),
    ('Machine Learning', 4),
    ('Power BI', 4);

INSERT INTO academico.aluno_curso VALUES (1, 4), (1, 11), (2, 1), (2, 2), (3, 4), (3, 3), (4, 4), (4, 6), (4, 5);

SELECT *
FROM academico.aluno