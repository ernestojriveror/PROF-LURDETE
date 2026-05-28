create table alunos (
	cod_aluno integer primary key  not null,
	nome varchar,
	CPF varchar,
	datnascimento date ,
	ENDEREÇO varchar,
	TELEFONE varchar 
)

create table matricula (
	cod_mat integer primary key not null,
	cod_disc integer, 
	cod_curso integer, 
	cod_aluno integer,
	cod_oferta_curso integer,

	constraint matricula_disciplinas
	foreign key (cod_disc)
	references disciplinas(cod_disc),

	constraint matricula_cursos
	foreign key (cod_curso)
	references cursos(cod_curso),

	constraint matricula_alunos
	foreign key (cod_aluno)
	references alunos(cod_aluno),

	constraint matricula_oferta_curso
	foreign key (cod_oferta_curso)
	references oferta_curso(cod_oferta_curso)
	
)

create table cursos (
	cod_curso integer primary key not null,
	nome_curso varchar(80),
	per_curso varchar,
	tot_alunos_curso integer
)

create table disciplinas (
	cod_disc integer primary key not null, 
	nome_disc varchar,
	tot_alunos varchar,
	mat_aluno varchar 

)

create table profesor (
	cod_prof integer primary key not null, 
	nome_prof varchar(50),
	CPF_prof varchar(15),
	dat_nac_prof date,
	ENDEREÇO varchar(80),
	TELEFONE varchar 
)

create table oferta_curso (
	cod_oferta_curso integer primary key not null,
	ano integer not null,
	semestre integer not null
)
create table oferta_disciplina (
	cod_oferta_disc integer primary key not null,
	cod_disc integer not null,
	cod_prof integer not null,

	constraint oferta_disciplina_disciplinas
	foreign key (cod_disc)
	references disciplinas(cod_disc),

	constraint oferta_disciplina_profesor
	foreign key (cod_prof)
	references profesor(cod_prof)
)

insert into alunos (cod_aluno, nome, CPF, datnascimento, ENDEREÇO, TELEFONE) values 
(1, 'Ernesto Rivero', '053.574.039-53', '09/11/1977', 'RUA XV DE NOVEMBRO', '(49)92002-9875'),
(2, 'Arturo Padilla', '054.235.698.-25', '12/12/2000', 'RUA CHUI', '(49)92003-9574'),
(3, 'Raul Rivero', '099.236.854-98', '16/08/2009', 'RUA XV DE NOVEMBRO', '(49)92005-2374');

insert into cursos (cod_curso, nome_curso, per_curso, tot_alunos_curso) values
(001, 'Programacao', '15/01/2026', 5  ),
(002, 'Aula de Portugues', '15/01/2026', 7),
(003, 'Informatica', '15/07/2026', 6);

select *
from disciplinas



