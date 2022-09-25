'Criando tabela curso'
CREATE TABLE tb_curso (
    id serial, 
    nome varchar(100), 
    carga_horaria int8,
	valor REAL,
	nota_prevista REAL, 
	nota_minima REAL,
    PRIMARY KEY (id) 
);
'Inserindo dados na tabela curso'
INSERT INTO tb_curso (nome, carga_horaria, valor, nota_prevista, nota_minima) VALUES ('HTML basico', 10, '80.00', '100.00', '70.00');


'Exibir tabela por ordem descrescente de id'
SELECT * FROM public.tb_curso
ORDER BY id ASC 


'Criando tabela turma'
CREATE TABLE tb_turma (
    id serial, 
    numero int8,
    inicio date,
	vagas int8,
	curso int8,
    PRIMARY KEY (id)
);

'Inserindo chave estrangeira'
ALTER TABLE tb_turma ADD FOREIGN key(curso) REFERENCES tb_curso(id); 

'Inserindo dados na tabela turma'
INSERT INTO tb_turma(numero, inicio, vagas, curso) VALUES(1, '2017-09-10', 30, 1)
INSERT INTO tb_turma(numero, inicio, vagas, curso) VALUES(2, '2022-05-20', 30, 1)


'Exibir a tabela turma'
SELECT * FROM public.tb_turma


'Criando a tabela aluno'
CREATE TABLE tb_aluno(
    cpf varchar(30),
	nome varchar(100),  
    nascimento date,
    PRIMARY KEY (cpf)
);

'Inserindo dados na tabela aluno'
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('736376983-19', 'Carlos Silva', '1990-07-21');
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('353847901-22', 'Maria Clara', '1991-09-03');
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('444123123-44', 'Ana Portes', '1995-05-21');
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('555098098-55', 'Pedro Tiago', '2001-10-15');

'Exibir a tabela aluno por ordem crescente de idade'
SELECT * FROM public.tb_aluno
ORDER BY nascimento ASC

DELETE FROM tb_resultado WHERE aluno_id = '444123123-44 '

'Criando tabela de matricula'
CREATE TABLE tb_matricula(
    turma_id int8,
    aluno_id varchar(30),
    data date,
	prestacoes int8,
	PRIMARY KEY(turma_id, aluno_id)
);

'Inserindo chave estrangeira'
ALTER TABLE tb_matricula ADD FOREIGN key(turma_id) REFERENCES tb_turma(id); 
ALTER TABLE tb_matricula ADD FOREIGN key(aluno_id) REFERENCES tb_aluno(cpf); 

'Inserindo dados na tabela de matricula'
INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 1, '736376983-19', '2017-09-05', 6)
INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 1, '353847901-22', '2017-09-06', 12)
INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 2, '736376983-19', '2022-05-13', 1)
INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 2, '444123123-44', '2022-05-13', 6)
INSERT INTO tb_matricula(turma_id, aluno_id, "data", prestacoes) VALUES( 2, '555098098-55', '2022-05-15', 10)


'Exibir tabela de matricula'
SELECT * FROM public.tb_matricula


'Criando tabela de avalição'
CREATE TABLE tb_avaliacao(
    id serial,
    nota REAL,
    data date,
	turma_id int8,
    PRIMARY KEY (id)
);

'Inserindo chave estrangeira'
ALTER TABLE tb_avaliacao ADD FOREIGN key(turma_id) REFERENCES tb_turma(id); 

'Inserindo dados na tabela de avaliação'
INSERT INTO tb_avaliacao(nota, "data", turma_id) VALUES( '40.0', '2017-10-20', 1)
INSERT INTO tb_avaliacao(nota, "data", turma_id) VALUES( '60.0', '2017-11-30', 1)
INSERT INTO tb_avaliacao(nota, "data", turma_id) VALUES( '50.0', '2022-06-20', 2)
INSERT INTO tb_avaliacao(nota, "data", turma_id) VALUES( '50.0', '2022-07-20', 2)


'Exibir tabale de avaliação'
SELECT * FROM public.tb_avaliacao


'Criando tabela de Resultado'
CREATE TABLE tb_resultado (
	aluno_id varchar(30),
	avaliacao_id int8,
	nota_obtida REAL,
	PRIMARY KEY(aluno_id, avaliacao_id)
);

'Inserindo chave primary key'
ALTER TABLE tb_resultado ADD PRIMARY KEY(aluno_id, avaliacao_id);

'Inserindo chave estrangeira'
ALTER TABLE tb_resultado ADD FOREIGN KEY(aluno_id) REFERENCES tb_aluno(cpf);
ALTER TABLE tb_resultado ADD FOREIGN key(avaliacao_id) REFERENCES tb_avaliacao(id);

'Inserindo dados dos resultados'
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '736376983-19', 1, '35.0');
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '353847901-22', 1, '36.5');
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '736376983-19', 2, '47.0');
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '353847901-22', 2, '52.4');
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '736376983-19', 3, '30.0');
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '444123123-44', 3, '50.0');
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '555098098-55', 3, '40.0');
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '736376983-19', 4, '35.0');
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '444123123-44', 4, '45.0');
INSERT INTO tb_resultado(aluno_id, avaliacao_id, nota_obtida) VALUES( '555098098-55', 4, '35.5');


'Exibir a tabela com os resultados'
SELECT aluno_id FROM public.tb_aluno WHERE aluno_id = '444123123-44'



'Comandos para deletar uma tabela especifica'
DROP TABLE tb_curso;
DROP TABLE tb_avaliacao;
DROP TABLE tb_aluno;
DROP TABLE tb_matricula;
DROP TABLE tb_turma;
DROP TABLE tb_resultado;