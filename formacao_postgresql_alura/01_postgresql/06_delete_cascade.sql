
DROP TABLE aluno_curso;
CREATE TABLE aluno_curso (
    aluno_id INTEGER,
    curso_id INTEGER,
    PRIMARY KEY (aluno_id, curso_id),
    FOREIGN KEY (aluno_id) REFERENCES aluno (id) ON DELETE CASCADE
    FOREIGN KEY (curso_id) REFERENCES curso (id)
);

INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (1,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (3,1);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (1,3);

DELETE FROM aluno WHERE id = 1;
SELECT
    t1.nome AS "Nome do Aluno",
    t3.nome AS "Nome do Curso"
FROM aluno AS t1

JOIN aluno_curso AS t2
ON t1.id = t2.aluno_id

JOIN curso AS t3
ON t2.curso_id = t3.id
