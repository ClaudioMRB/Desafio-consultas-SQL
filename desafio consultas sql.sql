CREATE TABLE tb_curso (
    id serial, 
    nome varchar(100), 
    carga_horaria int8,
	valor REAL,
	nota_prevista REAL, 
	nota_minima REAL,
    PRIMARY KEY (id) 
);

INSERT INTO tb_curso (nome, carga_horaria, valor, nota_prevista, nota_minima) VALUES ('HTML basico', 10, '80.00', '100.00', '70.00');

SELECT * FROM public.tb_curso


CREATE TABLE tb_turma (
    id serial, 
    numero int8,
    inicio date,
	vagas int8,
	curso int8,
    PRIMARY KEY (id)
);

INSERT INTO tb_turma(numero, inicio, vagas, curso) VALUES(1, '2017-09-10', 30, 1)
INSERT INTO tb_turma(numero, inicio, vagas, curso) VALUES(10, '2022-05-20', 30, 1)

SELECT * FROM public.tb_turma

CREATE TABLE tb_aluno(
    cpf varchar(30),
	nome varchar(100),  
    nascimento date,
    PRIMARY KEY (cpf)
);

INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('736376983-19', 'Carlos Silva', '1990-07-21')
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('353847901-22', 'Maria Clara', '1991-09-03')
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('444123123-44 ', 'Ana Portes', '1995-05-21')
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('555098098-55', 'Pedro Tiago', '2001-10-15') 

SELECT * FROM public.tb_aluno
ORDER BY nascimento ASC

CREATE TABLE tb_matricula(
    turma_id int8,
    aluno_id varchar(30),
    data date,
	prestacoes int8
);

INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 1, '736376983-19', '2017-09-05', 6)
INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 1, '353847901-22', '2017-09-06', 12)
INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 2, '736376983-19', '2022-05-13', 1)
INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 2, '444123123-44', '2022-05-13', 6)
INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 2, '555098098-55', '2022-05-15', 10)

SELECT * FROM public.tb_matricula

CREATE TABLE tb_avaliacao(
    id serial,
    nota REAL,
    data date,
	turma_id int8,
    PRIMARY KEY (id)
);

INSERT INTO tb_avaliacao(nota, "data", turma_id) VALUES( '40.0', '2017-10-20', 1)
INSERT INTO tb_avaliacao(nota, "data", turma_id) VALUES( '60.0', '2017-11-30', 1)
INSERT INTO tb_avaliacao(nota, "data", turma_id) VALUES( '50.0', '2022-06-20', 2)
INSERT INTO tb_avaliacao(nota, "data", turma_id) VALUES( '50.0', '2022-07-20', 2)

SELECT * FROM public.tb_avaliacao


CREATE TABLE tb_resultado (
	aluno_id varchar(30),
	avaliacao_id int8,
	nota_obtida REAL
);

INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '736376983-19', 1, '35.0')
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '353847901-22', 1, '36.5')
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '736376983-19', 2, '47.0')
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '353847901-22', 2, '52.4')
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '736376983-19', 3, '30.0')
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '444123123-44', 3, '50.0')
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '555098098-55', 3, '40.0')
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '736376983-19', 4, '35.0')
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '444123123-44', 4, '45.0')
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '555098098-55 ', 4, '35.5')

SELECT * FROM public.tb_resultado

DROP TABLE tb_curso;
DROP TABLE tb_avaliacao;
DROP TABLE tb_aluno;
DROP TABLE tb_matricula;
DROP TABLE tb_turma;
DROP TABLE tb_resultado