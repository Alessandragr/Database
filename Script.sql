-- ATP 41
-- Crie uma tabela de Produto com as seguintes colunas: id(identidade e incremental), nome, descrição, codigo e preço. Todas devem ser de preenchimento obrigatório.
create table produto (
	id int generated always as identity not null
	,nome varchar(50) not null
	,descricao varchar(200) not null
	,codigo int not null
	,preco float not null
);

-- Crie uma tabela de Categoria com as seguintes colunas: id(identidade e incremental), nome, descrição. Apenas a coluna descrição deve permitir valores nulos.
create table categoria (
	id int primary key generated always as identity not null
	,nome varchar(50) not null
	,descricao varchar(200) null
);

-- Crie uma tabela de Carro com as seguintes colunas: id(identidade e incremental), modelo e marca. Todas devem ser de preenchimento obrigatório
create table carro (
	id int generated always as identity not null
	,modelo varchar(50) not null
	,marca varchar(50) not null
);

-- Adicione duas novas colunas em carro. As colunas devem ser: chassi e ano. As duas colunas devem ser de preenchimento obrigatório.
alter table carro 
add column chassi varchar(50) not NULL;
alter table carro
add column ano varchar(10) not NULL;

-- Remove a coluna códido, da tabela Produto.
alter table produto 
drop column codigo;

-- Delete a tabela Carro.
drop table carro;

-- Adicione uma nova coluna na tabela Produto. A coluna deve ser o id da categoria e não deve permitir nulos.
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

-- Altere a descrição de dois produtos.
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

-- Altere o preço de todos os produtos tirando R$1,00 do preço atual.
update produto
set preco = preco-1;

-- ATP 43
-- Liste todos os dados de todas as colunas da tabela Categoria.
SELECT *
FROM categoria

-- Liste todos os dados de todas as colunas da tabela Produto.
SELECT *
FROM produtos

--  Liste os dados de todas as colunas da tabela Categoria, para as linhas que possuam uma descrição preenchida.
SELECT *
FROM produtos
WHERE IS NOT NULL 


-- ATP 44
