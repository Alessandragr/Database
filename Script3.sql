-- ATP 41
-- Crie uma tabela de Produto com as seguintes colunas: id(identidade e incremental), nome, descri??o, codigo e pre?o. Todas devem ser de preenchimento obrigat?rio.
create table produto (
	id int generated always as identity not null
	,nome varchar(50) not null
	,descricao varchar(200) not null
	,codigo int not null
	,preco float not null
);

-- Crie uma tabela de Categoria com as seguintes colunas: id(identidade e incremental), nome, descri??o. Apenas a coluna descri??o deve permitir valores nulos.
create table categoria (
	id int primary key generated always as identity not null
	,nome varchar(50) not null
	,descricao varchar(200) null
);

-- Crie uma tabela de Carro com as seguintes colunas: id(identidade e incremental), modelo e marca. Todas devem ser de preenchimento obrigat?rio
create table carro (
	id int generated always as identity not null
	,modelo varchar(50) not null
	,marca varchar(50) not null
);

-- Adicione duas novas colunas em carro. As colunas devem ser: chassi e ano. As duas colunas devem ser de preenchimento obrigat?rio.
alter table carro 
add column chassi varchar(50) not NULL;
alter table carro
add column ano varchar(10) not NULL;

-- Remove a coluna c?dido, da tabela Produto.
alter table produto 
drop column codigo;

-- Delete a tabela Carro.
drop table carro;

-- Adicione uma nova coluna na tabela Produto. A coluna deve ser o id da categoria e n?o deve permitir nulos.
alter table produto 
add column id_categoria int not NULL;

-- Adicione uma constraint a coluna id de categoria da tabela Produto. A constraint deve ser uma Foreign Key para a coluna Id, da tabela Categoria.
alter table produto 
add constraint FK_categoria foreign key (id_categoria)
references categoria(id);

-- ATP 42

-- Insira 3 categorias na tabela categoria.
insert into categoria  (nome, descricao) values ('A1','Descrito 1');
insert into categoria  (nome, descricao) values ('A2','Descrito 2');
insert into categoria  (nome, descricao) values ('A3','Descrito 3');

-- Insira 6 produtos na tabela produto.
insert into produto  (nome, descricao, preco, id_categoria) values ('A1', 'Descrito 1', 2, 1);
insert into produto  (nome, descricao, preco, id_categoria) values ('A2', 'Descrito 2', 4, 2);
insert into produto  (nome, descricao, preco, id_categoria) values ('A3', 'Descrito 3', 6, 3);
insert into produto  (nome, descricao, preco, id_categoria) values ('A4', 'Descrito 4', 8, 1);
insert into produto  (nome, descricao, preco, id_categoria) values ('A5', 'Descrito 5', 10, 1);
insert into produto  (nome, descricao, preco, id_categoria) values ('A6', 'Descrito 6', 12, 2);

-- Altere a descri??o de dois produtos.
update produto 
set
descricao ='Modificada'
where id >1 and id<8;
-- Delete um produto e uma categoria.
delete from produto 
where id=4;

delete from categoria 
where id=4;

-- Altere uma categoria de um produto.
update produto 
set id_categoria =2
where id_categoria =1;

-- Altere o pre?o de todos os produtos tirando R$1,00 do pre?o atual.
update produto
set preco = preco-1;

-- ATP 43
-- Liste todos os dados de todas as colunas da tabela Categoria.
select *
from categoria

-- Liste todos os dados de todas as colunas da tabela Produto.
select *
from produto

--  Liste os dados de todas as colunas da tabela Categoria, para as linhas que possuam uma descri??o preenchida.
select *
from categoria
where descricao is not null

-- Liste os dados das colunas Id, nome e pre?o da tabela Produto, para as linhas que possuem um nome iniciando com C.
select 
	id
	,nome
	,preco
	from produto 
	where nome like 'c%'

-- Liste os dados das colunas Id, nome e pre?o da tabela Produto e os dados id, nome e descri??o da tabela Categoria para as linhas que possuem um pre?o maior que 0	
select 
	p.id as "PessoaId"
	,p.nome as "PessoaNome"
	,p.preco as "Pre?oPessoa"
	,c.id as "CategoriaId"
	,c.nome as "CategoriaNome"
	,c.descricao as "CategoriaDescri"
	from produto as p
	join categoria as c 
	on p.preco >0;

-- Liste os dados de todas as colunas da tabela Produto que possuem categoria com Id maior que 2.
select *
from produto
where id>2;

-- Liste os dados de todas as colunas da tabela Categoria e o os dados da coluna nome da tabela Produto, para as categorias que est?o sendo utilizadas por produtos
select 
* 
	,p.nome
	from categoria as c
	join produto as p 
	on 
	p.id_categoria=c.id;

-- ATP 44
-- Crie uma estrutura de transa??o para executar duas inser??es. Entao, utilize o conjunto de begin, transaction, commit e end para criar um bloco de instru??es.
begin transaction;
	insert to produto (nome, descricao, preco, id_categoria) values ('New1', 'New1', 12, 7);
	insert to categoria (nome, descricao, ) values ('New2', 'New2');
	
	commit;
	end;
	
-- Execute todos os comandos em uma ?nica transa??o.
begin transaction;
-- Crie uma tabela Carros com id, marca e modelo.
create table carro (
	id int generated always as identity not null
	,marca varchar(50) not null
	,modelo varchar(50) not null
);
-- Insira dois novos carros dentro desta tabela.
	insert to carro (marca, modelo) values ('Marca1','Modelo1');
	insert to carro (marca, modelo) values ('Marca2','Modelo2');

commit;
end;

-- Atividade pa?s
begin transaction;
-- Crie uma tabela pa?s com id(PK), nome e sigla.
create table pais (
	id int generated always as identity not null
	,nome varchar(50) not null
	,sigla varchar(50) not null
);
-- Crie uma tabela estado com id(PK), nome, sigla e pais_id(FK);
create table estado (
	id int generated always as identity not null
	,nome varchar(50) not null
	,sigla varchar(50) not null
	,pais_id is not null
	constraint fk_pais foreign key (pais_id)
	references pais(id)
);
-- Crie uma tabela cidade com id(PK), nome e estado_id(FK);
create table cidade (
	id int generated always as identity not null
	,nome varchar(50) not null
	,estado_id is not null
	constraint fk_estado foreign key (estado_id)
	references estado(id)
);
-- Adicione um pa?s, um estado e uma cidade. Execute os DDL e DML em uma mesma transa??o
	insert to pais (nome, sigla) values ('Pais', 'P');
	insert to cidade (nome, sigla, pais_id) values ('Pais', 'P', 1);
	insert to estado (nome, estado_id) values ('Pais', 'P', 2);


commit;
end;

-- ATP 45

begin transaction;
	insert to pais (nome, sigla) values ('Pais', 'P');
	insert to cidade (nome, sigla, pais_id) values ('Pais', 'P', 1);
	insert to cidade (nome, sigla, pais_id) values ('Pais', 'P', 1);
	insert to cidade (nome, sigla, pais_id) values ('Pais', 'P', 1);
	insert to estado (nome, estado_id) values ('Pais', 'P', 2);
insert to estado (nome, estado_id) values ('Pais', 'P', 2);
insert to estado (nome, estado_id) values ('Pais', 'P', 2);
insert to estado (nome, estado_id) values ('Pais', 'P', 2);
	