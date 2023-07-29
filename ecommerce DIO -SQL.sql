CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY,
    Nome VARCHAR(255),
    Email VARCHAR(255),
    Endereco VARCHAR(255)
);

CREATE TABLE Pedido (
    ID_Pedido INT PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    Status VARCHAR(255),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE Produto (
    ID_Produto INT PRIMARY KEY,
    Nome VARCHAR(255),
    Descricao VARCHAR(255),
    Preco DECIMAL(10, 2)
);

CREATE TABLE Estoque (
    ID_Estoque INT PRIMARY KEY,
    Localizacao VARCHAR(255)
);

CREATE TABLE Fornecedor (
    ID_Fornecedor INT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco VARCHAR(255)
);

CREATE TABLE Vendedor_Terceirizado (
    ID_Vendedor INT PRIMARY KEY,
    Nome VARCHAR(255),
    Contato VARCHAR(255)
);

CREATE TABLE Produto_Pedido (
    ID_Pedido INT,
    ID_Produto INT,
    Quantidade INT,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

CREATE TABLE Produto_Estoque (
    ID_Produto INT,
    ID_Estoque INT,
    Quantidade INT,
    PRIMARY KEY (ID_Produto, ID_Estoque),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto),
    FOREIGN KEY (ID_Estoque) REFERENCES Estoque(ID_Estoque)
);

CREATE TABLE Fornecedor_Produto (
    ID_Fornecedor INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Fornecedor, ID_Produto),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

CREATE TABLE Vendedor_Produto (
    ID_Vendedor INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Vendedor, ID_Produto),
    FOREIGN KEY (ID_Vendedor) REFERENCES Vendedor_Terceirizado(ID_Vendedor),
    FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);



-- Recuperações simples com SELECT Statement
SELECT * FROM Produto;

-- Filtros com WHERE Statement
SELECT * FROM Produto WHERE Preco > 100;

-- Crie expressões para gerar atributos derivados
SELECT ID_Produto, Nome, Preco, Preco * 1.15 AS Preco_Com_Taxa FROM Produto;

-- Defina ordenações dos dados com ORDER BY
SELECT * FROM Produto ORDER BY Preco DESC;

-- Condições de filtros aos grupos – HAVING Statement
SELECT ID_Fornecedor, COUNT(ID_Produto) AS Numero_Produtos
FROM Fornecedor_Produto
GROUP BY ID_Fornecedor
HAVING Numero_Produtos > 5;

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
SELECT Pedido.ID_Pedido, Pedido.Data_Pedido, Cliente.Nome, Cliente.Email
FROM Pedido
JOIN Cliente ON Pedido.ID_Cliente = Cliente.ID_Cliente;