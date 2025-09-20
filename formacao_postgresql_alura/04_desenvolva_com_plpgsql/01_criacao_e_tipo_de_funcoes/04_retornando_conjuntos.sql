CREATE OR REPLACE FUNCTION instrutores_bem_pagos(valor_salario DECIMAL) RETURNS SETOF instrutor AS $$
    SELECT * FROM instrutor WHERE salario > valor_salario;
$$ LANGUAGE SQL


SELECT * FROM instrutores_bem_pagos(150)
