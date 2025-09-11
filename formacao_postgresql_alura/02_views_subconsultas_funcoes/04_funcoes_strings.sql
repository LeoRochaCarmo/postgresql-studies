-- Juntando primeiro e último nome (Forma 1)
SELECT
    primeiro_nome || ' ' || ultimo_nome AS nome_completo 
FROM aluno

-- Juntando primeiro e último nome (Forma 2)
-- Parâmetros NULLS seriam ignorados
SELECT
    CONCAT(primeiro_nome, ' ', NULL) AS nome_completo 
FROM aluno

-- Juntando funções
SELECT TRIM(UPPER(CONCAT('Vinicius', ' ', 'Dias') || ' '))

-- Pegando a incial do nome (Forma 1)
SELECT SUBSTRING(UPPER(CONCAT('Vinicius', ' ', 'Dias')) from 1 for 1)

-- Pegando a incial do nome (Forma 2)
SELECT LEFT(UPPER(CONCAT('Vinicius', ' ', 'Dias')), 1)
