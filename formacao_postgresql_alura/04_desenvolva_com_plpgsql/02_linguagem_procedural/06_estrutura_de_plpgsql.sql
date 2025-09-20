CREATE OR REPLACE FUNCTION primeira_pl() RETURNS INTEGER AS $$ 
    -- Declarando variáveis
    DECLARE
        primeira_variavel INTEGER DEFAULT 3;
    
    BEGIN
        -- Manipulando uma variável
        primeira_variavel := primeira_variavel * 2;

        DECLARE
            primeira_variavel INTEGER;
        BEGIN
            -- Não retorna esse valor. Essa variável só existe nesse bloco interno
            primeira_variavel := 7;
        END;

        -- Vários comandos em SQL
        RETURN primeira_variavel;
    END

$$ LANGUAGE plpgsql;

SELECT primeira_pl()

-- Há 3 formas de definir o valor padrão de uma variável ao declará-la:

-- DEFAULT
-- :=
-- =


-- Agora um detalhe importante de se citar é que no corpo da função, ou seja, entre os blocos BEGIN e END nós não 
-- podemos utilizar o DEFAULT para atribuir (ou modificar) o valor de uma variável. Apenas as 2 últimas opções são possíveis.

-- Sendo assim, o DEFAULT pode ser utilizado apenas dentro do bloco DECLARE para informar o valor padrão de uma variável.