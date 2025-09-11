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

-- Quantos cursos cada categoria tem
SELECT
    t2.nome AS categoria,
    COUNT(*) AS qtde_cursos
FROM curso AS t1

LEFT JOIN categoria AS t2
ON t1.categoria_id = t2.id

GROUP BY categoria

ORDER BY qtde_cursos DESC

-- Subquery para filtrar categorias com mais de 3 cursos
SELECT *
FROM (
    SELECT
        t2.nome AS categoria,
        COUNT(*) AS qtde_cursos
    FROM curso AS t1

    LEFT JOIN categoria AS t2
    ON t1.categoria_id = t2.id

    GROUP BY categoria

    ORDER BY qtde_cursos DESC
    ) AS cursos_por_categorias
    
WHERE qtde_cursos > 3

-- Abordagem mais direta
SELECT
    t2.nome AS categoria,
    COUNT(*) AS qtde_cursos
FROM curso AS t1

LEFT JOIN categoria AS t2
ON t1.categoria_id = t2.id

GROUP BY categoria
HAVING COUNT(*) > 3

ORDER BY qtde_cursos DESC


