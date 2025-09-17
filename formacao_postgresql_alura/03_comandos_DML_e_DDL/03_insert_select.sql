
CREATE TEMPORARY TABLE cursos_programacao (
    id_curso INTEGER PRIMARY KEY,
    nome_curso VARCHAR(255) NOT NULL
)

-- Inserindo dados em uma tabela temporária
INSERT INTO cursos_programacao
SELECT
    t1.id,
    t1.nome
FROM academico.curso AS t1
  
JOIN academico.categoria AS t2 
ON t2.id = t1.categoria_id

WHERE categoria_id = 2;

SELECT *
FROM cursos_programacao
