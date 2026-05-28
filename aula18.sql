CREATE USER secretaria WITH PASSWORD 'sec123';
CREATE USER aluno1 WITH PASSWORD 'alu123';
CREATE USER professor1 WITH PASSWORD 'prof123';


Create table Alunos (idAluno serial primary key,
Nomealuno varchar(45),
DatNascimento date,
cpf varchar(15),
Cidade Varchar(53));

--Secretária
GRANT INSERT, SELECT
ON alunos
TO secretaria;
--Professor
GRANT SELECT, UPDATE
ON alunos
TO professor1;
--Aluno
GRANT SELECT
ON alunos
TO aluno1;

CREATE USER financeiro WITH PASSWORD 'finb123'

CREATE TABLE pagamentos(
id SERIAL PRIMARY KEY,
descricao VARCHAR(100),
valor NUMERIC(10,2)
);

insert into alunos (Nomealuno, DatNascimento, CPF, Cidade) values 
('Ernesto Rivero', '09/11/1977', '053.574.039-53', 'Sao Miguel Do Oeste'),
('Arturo Padilla', '12/12/2000', '054.235.698.-25', 'Sao Miguel Do Oeste' ),
('Raul Rivero', '16/08/2009', '099.236.854-98', 'Sao Miguel Do Oeste');

Create table Secretaria (idSec serial primary key,
Nomealuno varchar(45),
DatNascimento date,
cpf varchar(15),
Cidade Varchar
)

