-- Desfazendo modificações na transação (ROLLBACK)
BEGIN;
DELETE FROM teste.cursos_programacao;
ROLLBACK;

-- Confirmando modficações na transação (COMMIT)
BEGIN;
DELETE FROM teste.cursos_programacao
WHERE nome_curso = 'Cobol';
COMMIT;

SELECT * FROM teste.cursos_programacao

-- IMPORTANTE! -> Rollback é feito automaticamente quando ocorre uma desconexão com o banco.

-- Revertendo uma parte específica da transação sem descartar o que foi feito antes (SAVEPOINT)
BEGIN;
INSERT INTO teste.cursos_programacao VALUES (60, 'Python Básico');
SAVEPOINT curso_python;
UPDATE teste.cursos_programacao
    SET nome_curso = 'Python Avançado'
    WHERE id_curso = 6;
-- oops. O id deveria ser 60 e não 6.
ROLLBACK TO curso_python;
UPDATE teste.cursos_programacao
    SET nome_curso = 'Python Avançado'
    WHERE id_curso = 60;
COMMIT;