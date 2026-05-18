--Exercicio 2 

INSERT INTO cargo (id_cargo, car_descricao, car_salario) VALUES
(01, 'Financeiro', 1000.00),
(02, 'Gerente', 800.00),
(10, 'Analista', 600.00),
(25, 'Programador', 500.00),
(102, 'Aprendiz', 200.00);


INSERT INTO departamento
(id_departamento, dep_descricao, dep_telefone) VALUES
(1001, 'RH', '(49)3300-1001'),
(1002, 'Desenvolvimento', '(49)3300-1002'),
(1003, 'Financeiro', '(49)3300-1003'),
(1004, 'Suporte', '(49)3300-1004'),
(1005, 'Vendas', '(49)3300-1005');

INSERT INTO empregado
(id_empregado, id_cargo, id_departamento, id_gerente,
emp_nome, emp_datadm, emp_salario, emp_comissao) VALUES
(1, 104, 1003, NULL, 'Carlos Silva', CURRENT_TIMESTAMP, 8000.00, NULL),
(2, 103, 1005, 1, 'Ana Souza', CURRENT_TIMESTAMP, 6000.00, NULL),
(3, 101, 1001, 1, 'Pedro Lima', CURRENT_TIMESTAMP, 5000.00, NULL),
(4, 105, 1002, 1, 'Maria Oliveira', CURRENT_TIMESTAMP, 4000.00, NULL),
(5, 102, 1004, 1, 'Ze Carioca', CURRENT_TIMESTAMP, 2000.00, NULL);

--Exercicio 3 

UPDATE empregado
SET id_cargo = 25, id_departamento = 1002, emp_salario = 4000.00
WHERE emp_nome = 'Ze Carioca';


--Exercicio 4 

UPDATE empregado
SET emp_datadm = '2026-04-20 00:00:00';

--Exercicio 5 

DELETE FROM empregado
WHERE emp_nome = 'Ze Carioca';






