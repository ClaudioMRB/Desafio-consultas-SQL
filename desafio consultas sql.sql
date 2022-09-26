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

'Saida data formato dd/mm/aaaa'
	SELECT numero,
	CASE WHEN EXTRACT( DAY FROM inicio) >=10 THEN CONCAT(EXTRACT( DAY FROM inicio), '/', EXTRACT( MONTH FROM inicio), '/', EXTRACT( YEAR FROM inicio)) 
	ELSE CONCAT('0', EXTRACT( DAY FROM inicio), '/', EXTRACT( MONTH FROM inicio), '/', EXTRACT( YEAR FROM inicio)) 
	END AS inicio 
	FROM tb_turma

'Exibir a tabela turma'
SELECT * FROM public.tb_turma


'Criando a tabela aluno'
CREATE TABLE tb_aluno(
    cpf varchar(30),
	nome varchar(100),  
    nascimento date,
    PRIMARY KEY (cpf)
);

'Extrai o dia da data inserida no formato dd/mm/aa'
SELECT cpf, nome, nascimento, CONCAT(EXTRACT( DAY FROM nascimento), '/', EXTRACT( MONTH FROM nascimento), '/', EXTRACT( YEAR FROM nascimento)) AS data FROM tb_aluno
'Extrai o ano menor que a data inserida no WHERE'
SELECT cpf, nome, nascimento, EXTRACT( YEAR FROM nascimento) AS dia FROM tb_aluno where EXTRACT ( YEAR FROM nascimento) < 2001
'Extrai o dia da data inserida, porém convertendo o tipo da saida com o CAST, renomeando a coluna com o AS'
SELECT cpf, nome, nascimento, CAST(EXTRACT( DAY FROM nascimento) AS REAL) AS dia FROM tb_aluno

'Inserindo dados na tabela aluno'
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('736376983-19', 'Carlos Silva', '1990-07-21');
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('353847901-22', 'Maria Clara', '1991-09-03');
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('444123123-44', 'Ana Portes', '1995-05-21');
INSERT INTO tb_aluno( cpf, nome, nascimento) VALUES('555098098-55', 'Pedro Tiago', '2001-10-15');

'Exibir a tabela aluno por ordem crescente de idade'
SELECT * FROM public.tb_aluno
ORDER BY nascimento ASC


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

SELECT * CAST ( EXTRACT (DAY FROM date) AS int) AS novo_nome_da_coluna FROM tb_sale; FROM tb_avaliacao

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
SELECT tb_resultado FROM luno_id 



'Comandos para deletar uma tabela especifica'
DROP TABLE tb_curso;
DROP TABLE tb_avaliacao;
DROP TABLE tb_aluno;
DROP TABLE tb_matricula;
DROP TABLE tb_turma;
DROP TABLE tb_resultado;

'QUESTÃO 1'

SELECT * FROM (
	SELECT nome AS curso, numero AS turma, CASE WHEN EXTRACT( DAY FROM inicio) >=10 THEN CONCAT(EXTRACT( DAY FROM inicio), '/', EXTRACT( MONTH FROM inicio), '/', EXTRACT( YEAR FROM inicio)) 
	ELSE CONCAT('0', EXTRACT( DAY FROM inicio), '/', EXTRACT( MONTH FROM inicio), '/', EXTRACT( YEAR FROM inicio)) 
	END AS inicio FROM tb_curso INNER JOIN tb_turma ON tb_turma.curso = tb_curso.id
	
) AS juncao

'QUESTÃO 2'
SELECT * FROM(
	
	SELECT numero FROM tb_turma
	
	SELECT nome FROM tb_curso

	SELECT nome, cpf FROM tb_aluno

) AS juncao





