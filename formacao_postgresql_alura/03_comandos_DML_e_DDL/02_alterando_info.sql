CREATE TEMPORARY TABLE a (
    coluna1 VARCHAR(255) NOT NULL CHECK(coluna1 <> ''),
    coluna2 VARCHAR(255) NOT NULL CHECK(coluna2 <> ''),
    UNIQUE(coluna1, coluna2)
);

INSERT INTO a VALUES ('a', 'c');

-- Alterando nome da tabela
ALTER TABLE a
RENAME TO teste

-- Alterando nome das colunas
ALTER TABLE teste RENAME coluna1 TO primeira_coluna;
ALTER TABLE teste RENAME coluna2 TO segunda_coluna;

-- Adicionando uma nova coluna
ALTER TABLE teste
ADD nome VARCHAR(255) NOT NULL DEFAULT 'Teste'

SELECT * FROM teste
