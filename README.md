# Desafio-consultas-SQL
Projeto para avaliação do módulo 7 - Consultas SQL Curso Formação Desenvolvedor Moderno / www.devsuperior.com.br turma 2022/2023

**--------------------CRIANDO AS TABELAS, INSERINDO DADOS E FAZENDO A LEITURA------------------------------------------------------------------------------------Estrutura do banco de dados----------------------------------------------------------------**

create table tb_curso (
    id int4 not null,
    carga_horaria int4,
    nome varchar(255),
    nota_minima numeric,
    nota_prevista numeric,
    valor numeric,
    primary key (id)
);

create table tb_turma (
    id int4 not null,
    inicio date,
    numero int4,
    vagas int4,
    curso_id int4,
    primary key (id),
    foreign key (curso_id) references tb_curso
);

create table tb_aluno (
    cpf varchar(255) not null,
    nascimento date,
    nome varchar(255),
    primary key (cpf)
);

create table tb_matricula (
    data date,
    prestacoes int4,
    aluno_id varchar(255) not null,
    turma_id int4 not null,
    primary key (aluno_id, turma_id),
    foreign key (aluno_id) references tb_aluno,
    foreign key (turma_id) references tb_turma
);

create table tb_avaliacao (
    id int4 not null,
    data date,
    nota numeric,
    turma_id int4,
    primary key (id),
    foreign key (turma_id) references tb_turma
);

create table tb_resultado (
    nota_obtida numeric,
    aluno_id varchar(255) not null,
    avaliacao_id int4 not null,
    primary key (aluno_id, avaliacao_id),
    foreign key (aluno_id) references tb_aluno,
    foreign key (avaliacao_id) references tb_avaliacao
);

-- CURSO HTML
INSERT INTO tb_curso (id, nome, carga_horaria, valor, nota_prevista, nota_minima) VALUES (1, 'HTML Básico', 10, 80.0, 100.0, 70.0);

-- DUAS TURMAS PARA O CURSO HTML
INSERT INTO tb_turma (id, numero, inicio, vagas, curso_id) VALUES (1, 1, '2017-09-10', 30, 1);
INSERT INTO tb_turma (id, numero, inicio, vagas, curso_id) VALUES (2, 10, '2022-05-20', 30, 1);

-- QUATRO ALUNOS
INSERT INTO tb_aluno (cpf, nome, nascimento) VALUES ('736376983-19', 'Carlos Silva', '1990-07-21');
INSERT INTO tb_aluno (cpf, nome, nascimento) VALUES ('353847901-22', 'Maria Clara', '1991-09-03');
INSERT INTO tb_aluno (cpf, nome, nascimento) VALUES ('444123123-44', 'Ana Portes', '1995-05-21');
INSERT INTO tb_aluno (cpf, nome, nascimento) VALUES ('555098098-55', 'Pedro Tiago', '2001-10-15');

-- DUAS MATRICULAS NA TURMA 1, E TRES MATRICULAS NA TURMA 2
INSERT INTO tb_matricula (turma_id, aluno_id, data, prestacoes) VALUES (1, '736376983-19', '2017-09-05', 6);
INSERT INTO tb_matricula (turma_id, aluno_id, data, prestacoes) VALUES (1, '353847901-22', '2017-09-06', 12);

INSERT INTO tb_matricula (turma_id, aluno_id, data, prestacoes) VALUES (2, '736376983-19', '2022-05-13', 1);
INSERT INTO tb_matricula (turma_id, aluno_id, data, prestacoes) VALUES (2, '444123123-44', '2022-05-13', 6);
INSERT INTO tb_matricula (turma_id, aluno_id, data, prestacoes) VALUES (2, '555098098-55', '2022-05-15', 10);

-- DUAS AVALIACOES NA TURMA 1, E DUAS AVALIACOES NA TURMA 2
INSERT INTO tb_avaliacao (id, nota, data, turma_id) VALUES (1, 40.0, '2017-10-20', 1);
INSERT INTO tb_avaliacao (id, nota, data, turma_id) VALUES (2, 60.0, '2017-11-30', 1);

INSERT INTO tb_avaliacao (id, nota, data, turma_id) VALUES (3, 50.0, '2022-06-20', 2);
INSERT INTO tb_avaliacao (id, nota, data, turma_id) VALUES (4, 50.0, '2022-07-20', 2);

-- RESULTADOS PARA CADA ALUNO EM CADA AVALIACAO DA TURMA 1 
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('736376983-19', 1, 35.0);
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('353847901-22', 1, 36.5);
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('736376983-19', 2, 47.0);
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('353847901-22', 2, 52.4);

-- RESULTADOS PARA CADA ALUNO EM CADA AVALIACAO DA TURMA 2
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('736376983-19', 3, 30.0);
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('444123123-44', 3, 50.0);
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('555098098-55', 3, 40.0);
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('736376983-19', 4, 35.0);
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('444123123-44', 4, 45.0);
INSERT INTO tb_resultado (aluno_id, avaliacao_id, nota_obtida) VALUES ('555098098-55', 4, 35.5);

**'QUESTÃO 1: nome do curso, número e data de início de cada turma de cada curso.'**

SELECT * FROM (
	SELECT nome AS curso, numero AS turma, CASE WHEN EXTRACT( DAY FROM inicio) >=10 THEN CONCAT(EXTRACT( DAY FROM inicio), '/', EXTRACT( MONTH FROM inicio), '/', EXTRACT( YEAR FROM inicio)) 
	ELSE CONCAT('0', EXTRACT( DAY FROM inicio), '/', EXTRACT( MONTH FROM inicio), '/', EXTRACT( YEAR FROM inicio)) 
	END AS inicio FROM tb_curso C INNER JOIN tb_turma ON C.id = tb_turma.curso_id
) AS juncao

**'QUESTÃO 2: nome do curso, número da turma, nome e CPF dos alunos de cada curso e cada turma. Os nomes das colunas devem ser curso, turma, aluno e cpf, conforme exemplo.'**

SELECT 
c.nome AS curso,
t.numero AS turma,
a.nome AS aluno,
m.aluno_id AS cpf
FROM tb_matricula m
INNER JOIN tb_aluno a ON m.aluno_id = a.cpf
INNER JOIN tb_turma t ON m.turma_id = t.id
INNER JOIN tb_curso c ON m.turma_id = t.id

**QUESTÃO 3: listagem de data e nota de todas avaliações já ocorridas, juntamente com nome, nota obtida por cada aluno em cada avaliação, e também qual a porcentagem de nota obtida em relação à nota da avaliação. Os resultados devem estar ordenados da avaliação mais recente para a mais antiga, e, para cada avaliação, os nomes dos alunos devem estar ordenados em ordem crescente. A porcentagem deve ter duas casas decimais.**

SELECT
CASE WHEN EXTRACT( DAY FROM data ) >=10 THEN CONCAT(EXTRACT( DAY FROM data), '/', EXTRACT( MONTH FROM data), '/', EXTRACT( YEAR FROM data)) 
	ELSE CONCAT('0', EXTRACT( DAY FROM data), '/', EXTRACT( MONTH FROM data), '/', EXTRACT( YEAR FROM data)) 
	END AS data,
av.nota,
a.nome,
r.nota_obtida,
ROUND (CAST (r.nota_obtida/av.nota * 100 AS numeric), 2) AS porcentagem
FROM tb_resultado r
INNER JOIN tb_aluno a ON r.aluno_id = a.cpf
INNER JOIN tb_avaliacao av ON av.id = r.avaliacao_id
ORDER BY av."data" DESC, a.nome ASC



**QUESTÃO 4: nome e nota total dos alunos da turma 10 (ATENÇÃO: você deve restringir a turma pelo número 10 dela, e não pelo id 2).**

SELECT
a.nome,
ROUND(CAST(SUM(r.nota_obtida) AS numeric), 2) AS total
FROM tb_resultado r
INNER JOIN tb_aluno a ON r.aluno_id = a.cpf
INNER JOIN tb_avaliacao av ON av.id = r.avaliacao_id
INNER JOIN tb_turma tm ON tm.id = av.turma_id
WHERE tm.numero = '10' GROUP BY a.nome 
