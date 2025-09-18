-- Criando tipos de dados (ENUM)
CREATE TYPE CLASSIFICACAO AS ENUM ('LIVRE', '12_ANOS', '14_ANOS', '16_ANOS', '18_ANOS');

CREATE TEMPORARY TABLE filme (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    classificacao CLASSIFICACAO
)

INSERT INTO filme (nome, classificacao) VALUES ('Harry Potter', '18_ANOS')

SELECT * FROM filme