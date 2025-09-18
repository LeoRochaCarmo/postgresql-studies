
CREATE SEQUENCE eu_criei;

SELECT NEXTVAL('eu_criei')

CREATE TEMPORARY TABLE auto (
    id INTEGER PRIMARY KEY DEFAULT NEXTVAL('eu_criei'),
    nome VARCHAR(255) NOT NULL
);

INSERT INTO auto (nome) VALUES ('Leonardo');
INSERT INTO auto (id, nome) VALUES (14, 'Caio'); -- Isso gera um erro
INSERT INTO auto (nome) VALUES ('João');

SELECT * FROM auto