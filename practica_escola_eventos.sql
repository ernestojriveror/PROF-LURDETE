create table alunos (
	cod_aluno integer primary key,
	nome varchar(50) not null,
	CPF varchar(15) not null,
	RG varchar(15) not null,
	datnascimento date not null,
	ENDERECO varchar,
	TELEFONE varchar 
);

create table eventos (
	cod_evento integer primary key,
	nome varchar(80) not null,
	data_evento date not null,
	hora_inicio time(14) not null,
	hora_fim time(30) not null
);

create table inscricao_alunos_eventos (
    cod_alu_even integer primary key,
	cod_aluno integer not null,
	cod_evento integer not null,

	foreign key (cod_aluno)
	references alunos(cod_aluno),

	constraint nscricao_alunos_eventos_eventos 
	foreign key (cod_evento)
	references eventos(cod_evento)
);
	
insert into alunos (cod_aluno, nome, CPF, RG, datnascimento, ENDERECO, TELEFONE) values 
(1, 'Ernesto Rivero', '053.574.039-53', 'DF25663', '09/11/1977', 'RUA XV DE NOVEMBRO', '(49)92002-9875'),
(2, 'Arturo Padilla', '054.235.698.-25', 'JGUY4521', '12/12/2000', 'RUA CHUI', '(49)92003-9574'),
(3, 'Raul Rivero', '099.236.854-98', 'HFYTF23565', '16/08/2009', 'RUA XV DE NOVEMBRO', '(49)92005-2374');

insert into eventos(cod_evento, nome, data_evento, hora_inicio, hora_fim) values
(001, 'Biblioteca', '15/05/2026', '09:00', '12:00'),
(002, 'Aula de Portugues', '20/05/2026', '16:30', '21:30'),
(003, 'Informatica', '10/06/2026', '19:00', '22:00');

insert into insc_alunos_eventos (cod_alu_even, cod_aluno, cod_evento) values
(01, 1, 001),
(02, 2, 002),
(03, 1, 003),
(04, 2, 003);

update alunos
set  nome = 'Pablo Rojas'
where nome = 'Arturo Padilla'

select *
from alunos

ALTER TABLE inscricao_alunos_eventos 
RENAME TO insc_alunos_eventos

select *
from insc_alunos_eventos

select *
from insc_alunos_eventos

select e.nome, a.nome
from eventos e
join insc_alunos_eventos i on i.cod_evento = e.cod_evento
join alunos a on a.cod_aluno = i.cod_aluno
order by e.nome asc, a.nome

delete alunos








