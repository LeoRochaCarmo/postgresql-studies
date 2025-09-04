-- Alunos em mais cursos
SELECT
    t2.primeiro_nome || ' ' || t2.ultimo_nome AS nome,
    COUNT(*) AS qtde_cursos
FROM aluno_curso AS t1

LEFT JOIN aluno as t2
ON t1.aluno_id = t2.id

GROUP BY 1

ORDER BY qtde_cursos DESC

-- Curso com mais alunos
SELECT
    nome AS curso,
    COUNT(*) AS qtde_alunos
FROM aluno_curso AS t1

LEFT JOIN curso AS t2
ON t1.curso_id = t2.id

GROUP BY curso

ORDER BY 2 DESC

-- Todos os cursos que estão em uma categoria que não possue espaço
SELECT
    categoria_id,
    nome
FROM curso

WHERE categoria_id IN (
    SELECT
        id 
    FROM categoria

    WHERE nome NOT LIKE '% %'
)


WITH teste AS (
    SELECT
        id 
    FROM categoria

    WHERE nome NOT LIKE '% %'
)
SELECT
    categoria_id,
    nome 
FROM curso AS t1

JOIN teste AS t2
ON t1.categoria_id = t2.id

SELECT
    categoria_id,
    nome
FROM curso

WHERE categoria_id IN (
    SELECT
        id 
    FROM categoria

    WHERE nome NOT LIKE '% %'
)

