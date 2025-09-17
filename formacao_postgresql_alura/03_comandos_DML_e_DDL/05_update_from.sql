-- Alterando nomes de 3 cursos
UPDATE academico.curso
SET nome = nome || ' ' || 'Básico'
WHERE nome IN ('PHP', 'Java', 'C++')

SELECT *
FROM academico.curso
ORDER BY id

-- Atualizando dados de uma tabela baseados em outra tabela (UPDATE FROM)
UPDATE teste.cursos_programacao AS t1
    SET nome_curso = t2.nome
FROM academico.curso AS t2 
WHERE t1.id_curso = t2.id
    AND t1.id_curso <> 10

SELECT * FROM teste.cursos_programacao
ORDER BY 1