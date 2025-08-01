CREATE TABLE CATEGORIA_PRODUTO (
CATEGORIAPRODUTOID INTEGER NOT NULL,
DS_CATEGORIA_PRODUTO VARCHAR(50) NOT NULL,
PRIMARY KEY(CATEGORIAPRODUTOID));

CREATE TABLE CLIENTE(
CLIENTEID INTEGER NOT NULL,
TIPO_CLIENTE CHAR(1) NOT NULL,
CPF_CNPJ_CLIENTE VARCHAR(18) not NULL,
NOME_CLIENTE VARCHAR(100) NOT NULL,
PRIMARY KEY(CLIENTEID));

CREATE TABLE PRODUTO (
PRODUTOID INTEGER NOT NULL,
CATEGORIAPRODUTOID INTEGER NOT NULL,
DS_PRODUTO VARCHAR(50) NOT NULL,
OBS_PRODUTO VARCHAR(300) NULL,
VL_VENDA_PRODUTO NUMERIC(15,2) NOT NULL,
DT_CADASTRO_PRODUTO TIMESTAMP NOT NULL,
STATUS_PRODUTO VARCHAR(10) NOT NULL,
PRIMARY KEY(PRODUTOID),
FOREIGN KEY (CATEGORIAPRODUTOID) REFERENCES
CATEGORIA_PRODUTO (CATEGORIAPRODUTOID));

CREATE TABLE ORCAMENTO(
ORCAMENTOID INTEGER NOT NULL,
CLIENTEID INTEGER NOT NULL,
DT_ORCAMENTO TIMESTAMP NOT NULL,
DT_VALIDADE_ORCAMENTO TIMESTAMP NOT NULL,
VL_TOTAL_ORCAMENTO NUMERIC(15,2) NOT NULL,
PRIMARY KEY(ORCAMENTOID),
FOREIGN KEY(CLIENTEID) REFERENCES CLIENTE(CLIENTEID));

CREATE TABLE ORCAMENTO_ITEM(
ORCAMENTOITEMID INTEGER NOT NULL,
ORCAMENTOID INTEGER NOT NULL,
PRODUTOID INTEGER NOT NULL,
QT_PRODUTO NUMERIC(15,2) NOT NULL,
VL_UNITARIO NUMERIC(15,2) NOT NULL,
VL_TOTAL NUMERIC(15,2) NOT NULL,
PRIMARY KEY(ORCAMENTOITEMID),
FOREIGN KEY(PRODUTOID) REFERENCES PRODUTO(PRODUTOID));

CREATE TABLE USUARIOS(
ID SERIAL PRIMARY KEY,
USUARIO VARCHAR(30),
NOME_COMPLETO VARCHAR(60),
SENHA VARCHAR(50));

--TABELA: CATEGORIA_PRODUTO
INSERT INTO CATEGORIA_PRODUTO (CATEGORIAPRODUTOID, DS_CATEGORIA_PRODUTO) VALUES (1, 'BASIC');
INSERT INTO CATEGORIA_PRODUTO (CATEGORIAPRODUTOID, DS_CATEGORIA_PRODUTO) VALUES (2,'PLATINUM');
INSERT INTO CATEGORIA_PRODUTO (CATEGORIAPRODUTOID, DS_CATEGORIA_PRODUTO) VALUES (3,'PREMIUM');
INSERT INTO CATEGORIA_PRODUTO (CATEGORIAPRODUTOID, DS_CATEGORIA_PRODUTO) VALUES (4,'ELITE');

--TABELA: CLIENTE

INSERT INTO CLIENTE (CLIENTEID, tipo_cliente,  CPF_CNPJ_CLIENTE, NOME_CLIENTE) VALUES (1, 'c',
'943.051.830-56', 'JOSÉ DA SILVA');
INSERT INTO CLIENTE (CLIENTEID, tipo_cliente, CPF_CNPJ_CLIENTE, NOME_CLIENTE) VALUES (2,'c',
'802.202.930-07','PEDRO DE OLIVEIRA');
INSERT INTO CLIENTE (CLIENTEID, tipo_cliente, CPF_CNPJ_CLIENTE, NOME_CLIENTE) VALUES (3,'c',
'637.502.500-14','MARIA EDUARDA MEIRELES');
INSERT INTO CLIENTE (CLIENTEID, tipo_cliente, CPF_CNPJ_CLIENTE, NOME_CLIENTE) VALUES (4,'c',
'997.192.890-66','SANDRA GOMES');

--TABELA: PRODUTO

INSERT INTO PRODUTO (PRODUTOID, CATEGORIAPRODUTOID , DS_PRODUTO, OBS_PRODUTO,
VL_VENDA_PRODUTO, DT_CADASTRO_PRODUTO, STATUS_PRODUTO) VALUES (1, 1, 'CHAPA METALICA','CHAPA GENERICA', 106.22, '18/02/2022', 'ATIVO');
INSERT INTO PRODUTO (PRODUTOID, CATEGORIAPRODUTOID , DS_PRODUTO, OBS_PRODUTO, VL_VENDA_PRODUTO, DT_CADASTRO_PRODUTO, STATUS_PRODUTO) VALUES (2, 1,
'FOLHA METALICA','FOLHA GENERICA', 10.88, '18/02/2022', 'ATIVO'); 
INSERT INTO PRODUTO (PRODUTOID, CATEGORIAPRODUTOID , DS_PRODUTO, OBS_PRODUTO, VL_VENDA_PRODUTO, DT_CADASTRO_PRODUTO, STATUS_PRODUTO) VALUES (3, 3,
'CHAPA DOURADA','CHAPA ESPECIFICA', 158.88,'18/02/2022','ATIVO'); 
INSERT INTO PRODUTO (PRODUTOID, CATEGORIAPRODUTOID , DS_PRODUTO, OBS_PRODUTO,
VL_VENDA_PRODUTO, DT_CADASTRO_PRODUTO, STATUS_PRODUTO) VALUES (4, 4, 'FOLHA DIAMANTE','FOLHA UNICA', 665.33,'18/02/2022','ATIVO');
--TABELA: ORCAMENTO

INSERT INTO ORCAMENTO (ORCAMENTOID, CLIENTEID, DT_ORCAMENTO, DT_VALIDADE_ORCAMENTO,
VL_TOTAL_ORCAMENTO) VALUES (1, 1,'18/02/2022','19/02/2022', 10700.00);
INSERT INTO ORCAMENTO (ORCAMENTOID, CLIENTEID, DT_ORCAMENTO, DT_VALIDADE_ORCAMENTO,
VL_TOTAL_ORCAMENTO) VALUES (2, 3,'17/02/2022','19/02/2022', 2700.00);
INSERT INTO ORCAMENTO (ORCAMENTOID, CLIENTEID, DT_ORCAMENTO, DT_VALIDADE_ORCAMENTO,
VL_TOTAL_ORCAMENTO) VALUES (3, 4, '18/02/2022', '19/02/2022', 1200.00);
INSERT INTO ORCAMENTO (ORCAMENTOID, CLIENTEID, DT_ORCAMENTO, DT_VALIDADE_ORCAMENTO,
VL_TOTAL_ORCAMENTO) VALUES (4, 2, '17/02/2022','19/02/2022', 8000.00);

--TABELA: ORCAMENTO_ITEM

INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (1, 1, 1, 10, 100.00, 1000.00);
INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (2, 1, 2, 20, 10.00, 200.00);
INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (3, 1, 4, 30, 500.00, 1500.00);
INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (4, 1, 3, 40, 200.00, 8000.00);

--TABELA: ORCAMENTO_ITEM

INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (5, 2, 1, 10, 100.00, 1000.00);
INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (6, 2, 2, 20, 10.00, 200.00);
INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (7, 2, 4, 30, 500.00, 1500.00);
INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (8, 3, 1, 10, 100.00, 1000.00);
INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (9, 3, 2, 20, 10.00, 200.00);
INSERT INTO ORCAMENTO_ITEM (ORCAMENTOITEMID, ORCAMENTOID, PRODUTOID, QT_PRODUTO,
VL_UNITARIO, VL_TOTAL) VALUES (10, 4, 3, 40, 200.00, 8000.00);

select *from categoria_produto;
select *from cliente;
select *from orcamento;
select *from orcamento_item;
select *from produto;
select *from usuarios; 


--ex1.
select *from PRODUTO where status_produto = 'ATIVO';
--ex2.
select ds_produto,ds_categoria_produto from PRODUTO prod 
left join CATEGORIA_PRODUTO catProd 
on prod.categoriaprodutoid = catProd.categoriaprodutoid;
--ex3.
select *from produto where vl_venda_produto > 50;
--ex4.
select orc.*,nome_cliente from ORCAMENTO orc join CLIENTE cli on orc.clienteid = cli.clienteid;
--ex5.
select orc.*,ds_produto,ds_categoria_produto from ORCAMENTO_ITEM orc 
join produto p on orc.produtoid = p.produtoid 
join categoria_produto catProd on p.categoriaprodutoid = catProd.categoriaprodutoid;
--ex6.
select *from ORCAMENTO where dt_orcamento between '01/02/2022' and '18/02/2022';
--ex7.
select *FROM ORCAMENTO where dt_validade_orcamento < CURRENT_DATE;
--ex8.
select produtoid, MAX(vl_total) from ORCAMENTO_ITEM group by produtoid;
--ex9.
select MAX(vl_total_orcamento) from ORCAMENTO;
--ex10.
select sum(vl_total_orcamento) from ORCAMENTO;
--ex11.
select orcamentoid, SUM(qt_produto) from ORCAMENTO_ITEM group by orcamentoid;


CREATE SEQUENCE usuario_idtemp;
SELECT nextval ('usuario_idtemp') AS COD;

create sequence cliente_idtemp;
select nextval('cliente_idtemp');

select * from categoria_produto;

alter table categoria_produto add descricao varchar (100);

update categoria_produto 
set descricao = 'Itens básicos do dia a dia'
where categoriaprodutoid  = 1;

update categoria_produto 
set descricao = 'Itens de Platina'
where categoriaprodutoid  = 2;

update categoria_produto 
set descricao = 'Itens Premium'
where categoriaprodutoid  = 3;

update categoria_produto 
set descricao = 'Itens da Elite'
where categoriaprodutoid  = 4;

create sequence categoria_id;
select nextval('categoria_id');

alter table cliente 
alter column tipo_cliente type varchar(20); 

update cliente c 
set tipo_cliente = 'Pessoa Física'

select * from cliente c;

alter table cliente add telefone_cliente varchar(20);
alter table cliente add email_cliente varchar(100);

update cliente c 
set telefone_cliente = '(44)99999-9999'
where clienteid = 1;

update cliente c 
set telefone_cliente = '(44)98888-8888'
where clienteid = 2;

update cliente c 
set telefone_cliente = '(43)99898-9898'
where clienteid = 3;

update cliente c 
set telefone_cliente = '(41)98888-9999'
where clienteid = 4;

update cliente c
set email_cliente = 'zezinho@gmail.com'
where clienteid = 1;

update cliente c
set email_cliente = 'pepeoliver@hotmail.com'
where clienteid = 2;

update cliente c
set email_cliente = 'mariamaria@yahoo.com.br'
where clienteid = 3;

update cliente c
set email_cliente = 'sandra123@gmail.com'
where clienteid = 4;

alter table cliente 
alter column telefone_cliente set not null;

alter table cliente 
alter column email_cliente set not null;



