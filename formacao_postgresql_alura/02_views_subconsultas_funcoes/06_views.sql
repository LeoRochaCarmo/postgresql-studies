CREATE VIEW vw_cursos_por_categoria AS
    SELECT
        t2.nome AS categoria,
        COUNT(*) AS qtde_cursos
    FROM curso AS t1

    LEFT JOIN categoria AS t2
    ON t1.categoria_id = t2.id

    GROUP BY categoria

CREATE VIEW vw_cursos_programacao AS  
    SELECT
        t1.nome
    FROM curso AS t1

    JOIN categoria AS t2
    ON t1.categoria_id = t2.id

    WHERE t2.nome = 'Programação'


-- Juntando view com um tabela
SELECT
    t2.id,
    t1.*
FROM vw_cursos_por_categoria AS t1

LEFT JOIN categoria AS t2
ON t1.categoria = t2.nome