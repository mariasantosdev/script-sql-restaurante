create database Bancotcc;

use Bancotcc;

create table funcionario (
	cod_func int auto_increment,
	nome_func varchar(100) not null,
	email_func varchar (50),
	senha_func varchar (15) NOT NULL,
    tipo_acesso bit not null,
    primary key (cod_func));

create table Endereco (
	cod_endereco int auto_increment,
	lodradouro varchar (40) NOT NULL,
	numero varchar (10) NOT NULL,
	complemento varchar (100),
	cidade varchar (30) NOT NULL,
	estado varchar (20) NOT NULL,
	cod_cliente int,
    primary key (cod_endereco));

create table cliente (
	cod_cliente int auto_increment,
	nome_cliente varchar (60) NOT NULL,
	telefone_cliente varchar (11) ,
	email_cliente varchar (50),
    senha_cliente varchar(15),
    cod_endereco int,
    primary key (cod_cliente),
       foreign key (cod_endereco) references Endereco (cod_endereco));

create table Produto(
cod_Produto int auto_increment,
valor double NOT NULL,
Descricao varchar(150),
Quantidade int NOT NULL,
Categoria varchar(50),
Nome varchar(50) NOT NULL,
primary key (cod_Produto)
);

create table Item(
cod_item int auto_increment,
valor_Item double not null,
Descricao varchar(200),
Nome_Item varchar(130) not null,
cod_Produto int,
primary key (cod_item),
       foreign key (cod_Produto) references Produto (cod_Produto)
);

create table Comanda(
cod_comanda int auto_increment,
valor_total double,
cod_Produto int,
cod_item int,
num_mesas int,
cod_cliente int,
   primary key (cod_comanda),
       foreign key (cod_Produto) references Produto (cod_Produto),
       foreign key (cod_item) references Item (cod_item),
        foreign key (cod_cliente) references cliente (cod_cliente)
       );

create table Reserva 
(
cod_reserva int auto_increment,
Mesas_Disponiveis varchar(15),
Qtd_Pessoas int,
Hora_data datetime,
cod_Cliente int,
cod_endereco int,
cod_func int,
primary key (cod_reserva),
foreign key (cod_func) references funcionario (cod_func),
       foreign key (cod_cliente) references cliente (cod_cliente),
       foreign key (cod_endereco) references Endereco (cod_endereco));

create table Pagamento
(
cod_Pagamento int auto_increment,
Hora_data datetime,
Tipo varchar(100),
cod_Cliente int,
cod_comanda int,
primary key (cod_Pagamento),
       foreign key (cod_cliente) references cliente (cod_cliente),
        foreign key (cod_comanda) references Comanda (cod_comanda));

create table Historico
(
cod_historico int auto_increment,
Hora_data datetime,
Status_Historico varchar(20),
cod_Item int,
cod_Produto int,
cod_Pagamento int,
cod_cliente int,
cod_reserva int,
primary key (cod_historico),
foreign key (cod_Pagamento) references Pagamento (cod_Pagamento),
foreign key (cod_reserva) references Reserva (cod_reserva),
foreign key (cod_Item) references Item (cod_Item),
foreign key (cod_Produto) references Produto (cod_Produto),
foreign key (cod_cliente) references cliente (cod_cliente)
);
DELIMITER $S
 create procedure InsertClienteeEndereco(
    IN cod_cliente int,
	IN nome_cliente varchar (60),
	IN telefone_cliente varchar (11),
	IN email_cliente varchar (50),
    IN senha_cliente varchar(15),
    IN cod_endereco int,
    IN lodradouro varchar (40),
	IN numero varchar (10),
	IN complemento varchar (100),
	IN cidade varchar (30),
	IN estado varchar (20))

    
    BEGIN 
    INSERT
	INTO
	cliente(cod_cliente,
	nome_cliente,
	telefone_cliente,
	email_cliente,
	senha_cliente)
VALUES(cod_cliente,
nome_cliente,
telefone_cliente,
email_cliente,
senha_cliente);
	INSERT
	INTO
	Endereco(cod_endereco,
	lodradouro,
	numero,
	complemento,
	cidade,
	estado)
VALUES(cod_endereco,
lodradouro,
numero,
complemento,
cidade,
estado);
END $S
CALL InsertClienteeEndereco(3,
'madu',
'11956775689',
'madu@gmail.com',
'saddf2',
3,
'rua da baiota',
450,
'casa A',
'São Paulo',
'São Paulo');
CALL InsertClienteeEndereco(4,
'leticia',
'11956783790',
'lelinda@gmail.com',
'le12j',
4,
'qualquer rua do morro doce',
24,
'casa B',
'São Paulo',
'São Paulo');
CALL InsertClienteeEndereco(5,
'lucas',
'1195672289',
'lucas@gmail.com',
'l34kj12j',
5,
'rua das lagostas',
10,
'nenhum',
'Araçatuba',
'São Paulo');
DELIMITER $S
 create procedure ProdutoeItem(
    IN cod_Produto int,
	IN valor double,
	IN Quantidade int,
	IN Nome varchar (50),
    IN cod_item int,
    IN valor_Item double,
    IN Nome_Item varchar(130))
    
    
    
BEGIN

INSERT
	INTO
	Produto(cod_Produto,
	valor,
	Quantidade,
	Nome)
VALUES(cod_Produto,
valor,
Quantidade,
Nome);
INSERT
	INTO
	Item(cod_item,
	valor_Item,
	Nome_Item)
VALUES(cod_item,
valor_Item,
Nome_Item);
END $S
    CALL ProdutoeItem (2,
'23',
2,
'welliton',
2,
'2',
'temaki');
    CALL ProdutoeItem(3,
'30.90',
3,
'alex',
3,
'9.00',
'niguiri');
