CREATE TABLE Cliente (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Endereco VARCHAR(100),
    Telefone VARCHAR(20)
);

CREATE TABLE ClientePJ (
    CNPJ INT PRIMARY KEY,
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

CREATE TABLE ClientePF (
    CPF INT PRIMARY KEY,
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

CREATE TABLE Pedido (
    ID INT PRIMARY KEY,
    Data DATE,
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

CREATE TABLE Produto (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Preco DECIMAL(10, 2),
    Fornecedor_ID INT,
    FOREIGN KEY (Fornecedor_ID) REFERENCES Fornecedor(ID)
);

CREATE TABLE Fornecedor (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE Estoque (
    Produto_ID INT PRIMARY KEY,
    Quantidade INT,
    FOREIGN KEY (Produto_ID) REFERENCES Produto(ID)
);

CREATE TABLE FormaPagamento (
    ID INT PRIMARY KEY,
    Descricao VARCHAR(100)
);

CREATE TABLE Pagamento (
    Pedido_ID INT,
    FormaPagamento_ID INT,
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(ID),
    FOREIGN KEY (FormaPagamento_ID) REFERENCES FormaPagamento(ID)
);

CREATE TABLE Entrega (
    Pedido_ID INT PRIMARY KEY,
    Status VARCHAR(100),
    CodigoRastreio VARCHAR(20),
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(ID)
);

-- Quantos pedidos foram feitos por cada cliente?
SELECT c.Nome, COUNT(p.ID) AS QuantidadePedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.ID = p.Cliente_ID
GROUP BY c.Nome;


-- Algum vendedor também é fornecedor?
SELECT f.Nome
FROM Fornecedor f
INNER JOIN Produto p ON f.ID = p.Fornecedor_ID;

-- Relação de produtos, fornecedores e estoques:
SELECT p.Nome AS Produto, f.Nome AS Fornecedor, e.Quantidade AS Estoque
FROM Produto p
INNER JOIN Fornecedor f ON p.Fornecedor_ID = f.ID
INNER JOIN Estoque e ON p.ID = e.Produto_ID;

-- Relação de nomes dos fornecedores e nomes dos produtos:
SELECT f.Nome AS Fornecedor, p.Nome AS Produto
FROM Fornecedor f
INNER JOIN Produto p ON f.ID = p.Fornecedor_ID;
