/* Criar uma função que insira um curso em determinada categoria. 
Porém, o que vamos informar não é o id da categoria, mas sim um nome.
Se uma categoria com esse nome já existir, utilizaremos apenas o id. 
Caso não exista ainda uma categoria com esse nome, criaremos uma 
categoria para só depois criar o curso.
*/

-- Minha resolução
CREATE OR REPLACE FUNCTION criar_curso(nome_curso VARCHAR, nome_categoria VARCHAR) RETURNS void AS $$
    DECLARE
        id_categoria INTEGER;
    BEGIN
        IF EXISTS(SELECT * FROM categoria WHERE nome = nome_categoria) THEN
            SELECT id FROM categoria WHERE nome = nome_categoria INTO id_categoria;
            INSERT INTO curso(nome, categoria_id) VALUES(nome_curso, id_categoria);
        ELSE
            INSERT INTO categoria(nome) VALUES(nome_categoria);
            SELECT id FROM categoria WHERE nome = nome_categoria INTO id_categoria;
            INSERT INTO curso(nome, categoria_id) VALUES(nome_curso, id_categoria);
        END IF;
    END;
$$ LANGUAGE PLPGSQL

-- Solução do instrutor
CREATE OR REPLACE FUNCTION criar_curso(nome_curso VARCHAR, nome_categoria VARCHAR) RETURNS void AS $$
    DECLARE
        id_categoria INTEGER;
    BEGIN
        SELECT id FROM categoria WHERE nome = nome_categoria INTO id_categoria;
        
        IF NOT FOUND THEN
            INSERT INTO categoria(nome) VALUES(nome_categoria) RETURNING id INTO id_categoria;
        END IF;

        INSERT INTO curso(nome, categoria_id) VALUES(nome_curso, id_categoria);
    END;
$$ LANGUAGE PLPGSQL

SELECT criar_curso('Java', 'Programação');

SELECT * FROM categoria;

SELECT * FROM curso;
