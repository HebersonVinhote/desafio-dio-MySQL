CREATE TABLE Cliente (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Endereco VARCHAR(100),
    Telefone VARCHAR(20)
);

CREATE TABLE Veiculo (
    ID INT PRIMARY KEY,
    Cliente_ID INT,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Ano INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

CREATE TABLE Servico (
    ID INT PRIMARY KEY,
    Descricao VARCHAR(100),
    Preco DECIMAL(10, 2)
);

CREATE TABLE OrdemServico (
    ID INT PRIMARY KEY,
    Cliente_ID INT,
    Veiculo_ID INT,
    Data DATE,
    Servico_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID),
    FOREIGN KEY (Veiculo_ID) REFERENCES Veiculo(ID),
    FOREIGN KEY (Servico_ID) REFERENCES Servico(ID)
);

CREATE TABLE Funcionario (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Cargo VARCHAR(50)
);

CREATE TABLE Peca (
    ID INT PRIMARY KEY,
    Descricao VARCHAR(100),
    Preco DECIMAL(10, 2),
    Fornecedor_ID INT,
    FOREIGN KEY (Fornecedor_ID) REFERENCES Fornecedor(ID)
);

CREATE TABLE Fornecedor (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE Estoque (
    Peca_ID INT PRIMARY KEY,
    Quantidade INT,
    FOREIGN KEY (Peca_ID) REFERENCES Peca(ID)
);

-- Inserindo clientes
INSERT INTO Cliente (ID, Nome, Endereco, Telefone)
VALUES (1, 'Cliente 1', 'Endereco 1', '1234567890');

-- Inserindo veículos
INSERT INTO Veiculo (ID, Cliente_ID, Marca, Modelo, Ano)
VALUES (1, 1, 'Marca 1', 'Modelo 1', 2020);

-- Inserindo serviços
INSERT INTO Servico (ID, Descricao, Preco)
VALUES (1, 'Servico 1', 100.00);

-- Inserindo ordens de serviço
INSERT INTO OrdemServico (ID, Cliente_ID, Veiculo_ID, Data, Servico_ID)
VALUES (1, 1, 1, '2023-07-10', 1);

-- Inserindo funcionários
INSERT INTO Funcionario (ID, Nome, Cargo)
VALUES (1, 'Funcionario 1', 'Cargo 1');

-- Inserindo peças
INSERT INTO Peca (ID, Descricao, Preco, Fornecedor_ID)
VALUES (1, 'Peca 1', 50.00, 1);

-- Inserindo fornecedores
INSERT INTO Fornecedor (ID, Nome)
VALUES (1, 'Fornecedor 1');

-- Inserindo estoque
INSERT INTO Estoque (Peca_ID, Quantidade)
VALUES (1, 100);

-- Recuperação simples com SELECT Statement:
SELECT * FROM Cliente;

-- Filtros com WHERE Statement:
SELECT * FROM Veiculo WHERE Marca = 'Marca 1';

-- Expressões para gerar atributos derivados:
SELECT *, Preco * Quantidade AS Total FROM Peca;

-- Ordenações dos dados com ORDER BY:
SELECT * FROM Servico ORDER BY Preco DESC;

-- Condições de filtros aos grupos – HAVING Statement:
SELECT Veiculo_ID, COUNT(*) AS QuantidadeOrdens
FROM OrdemServico
GROUP BY Veiculo_ID
HAVING COUNT(*) > 1;

-- Junções entre tabelas para fornecer uma perspectiva mais complexa dos dados:
SELECT c.Nome AS Cliente, v.Marca, v.Modelo, s.Descricao AS Servico
FROM Cliente c
JOIN Veiculo v ON c.ID = v.Cliente_ID
JOIN OrdemServico os ON v.ID = os.Veiculo_ID
JOIN Servico s ON os.Servico_ID = s.ID;
