-- Calcular idade dos alunos

SELECT
    primeiro_nome || ' ' || ultimo_nome AS nome_completo,
    (NOW()::DATE - data_nascimento) / 365 AS idade, -- forma 1
    SUBSTRING(CAST(AGE(data_nascimento) AS TEXT), 1, 2) AS idade, -- forma 2
    EXTRACT(YEAR FROM AGE(data_nascimento)) -- forma 3 (melhor)

FROM aluno

-- Formatando a data
SELECT TO_CHAR(NOW(), 'DD-MM-YYYY')