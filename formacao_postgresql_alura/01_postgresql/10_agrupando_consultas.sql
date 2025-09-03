SELECT 
    nome,
    sobrenome,
    COUNT(*)
FROM funcionarios

GROUP BY nome, sobrenome

ORDER BY nome;

-- Filtrando usando HAVING (cursos sem alunos)
SELECT
    t1.nome AS curso,
    COUNT(aluno_id) AS qtde_alunos
FROM curso AS t1

LEFT JOIN aluno_curso AS t2
ON t1.id = t2.curso_id

LEFT JOIN aluno AS t3
ON t3.id = t2.aluno_id

GROUP BY curso

HAVING COUNT(aluno_id) = 0




