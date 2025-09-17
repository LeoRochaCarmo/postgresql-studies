CREATE SCHEMA teste;

CREATE TABLE teste.cursos_programacao (
    id_curso INTEGER PRIMARY KEY,
    nome_curso VARCHAR(255) NOT NULL
);

INSERT INTO teste.cursos_programacao
SELECT
    t1.id,
    t1.nome
FROM academico.curso AS t1
  
JOIN academico.categoria AS t2 
ON t2.id = t1.categoria_id

WHERE categoria_id = 2;

SELECT * FROM teste.cursos_programacao

-- Importando dados de um arquivo csv
-- Como estou usando o Docker, o arquivo PRECISA estar dentro do volume mapeado
COPY teste.cursos_programacao(id_curso, nome_curso)
FROM '/var/lib/postgresql/data/cursos.csv'
DELIMITER ','
ENCODING 'UTF8'
CSV HEADER 
QUOTE '"' 
ESCAPE '"';

SELECT *
FROM teste.cursos_programacao

-- Exportando dados
COPY teste.cursos_programacao(id_curso, nome_curso)
TO '/var/lib/postgresql/data/cursos.txt'
ENCODING 'UTF8';
