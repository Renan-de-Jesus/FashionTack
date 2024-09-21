CREATE DATABASE FashionTrack
GO

CREATE TABLE Usuario (
    ID_Usuario INT IDENTITY(1,1),
    NomeCompleto VARCHAR(100) NOT NULL,
    Usuario VARCHAR(50) NOT NULL UNIQUE,
    Senha VARCHAR(255) NOT NULL,
    Adm BIT NOT NULL,  -- 0 para n�o, 1 para sim
    CONSTRAINT PK_Usuario PRIMARY KEY (ID_Usuario)
);

CREATE TABLE Cidade (
    ID_Cidade INT IDENTITY(1,1),
    Descricao VARCHAR(100) NOT NULL,
    UF CHAR(2) NOT NULL,
    CONSTRAINT PK_Cidade PRIMARY KEY (ID_Cidade)
);

CREATE TABLE Cliente (
    ID_Cliente INT IDENTITY(1,1),
    Nome VARCHAR(50) NOT NULL,
    Sobrenome VARCHAR(50) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    Telefone VARCHAR(15) NOT NULL,
    Endereco VARCHAR(150) NOT NULL,
    ID_Cidade INT NOT NULL,
    CONSTRAINT PK_Cliente PRIMARY KEY (ID_Cliente),
    CONSTRAINT FK_Cliente_Cidade FOREIGN KEY (ID_Cidade) REFERENCES Cidade(ID_Cidade)
);

CREATE TABLE Fornecedor (
    ID_Fornecedor INT IDENTITY(1,1),
    NomeRazaoSocial VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Endereco VARCHAR(150) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    ID_Cidade INT NOT NULL,
    CONSTRAINT PK_Fornecedor PRIMARY KEY (ID_Fornecedor),
    CONSTRAINT FK_Fornecedor_Cidade FOREIGN KEY (ID_Cidade) REFERENCES Cidade(ID_Cidade)
);

-- Interessante em algum momento criar uma tabela MARCAS, para que possa ser feito relatorios depois, evitando que o usuario digite 2 nomes que seriam iguais, de forma diferente
CREATE TABLE Produto (
    ID_Produto INT IDENTITY(1,1),
    CodigoMarca VARCHAR(50),
    Cor VARCHAR(30),
    Descricao VARCHAR(255) NOT NULL,
    Tamanho VARCHAR(10) NOT NULL,
    Genero VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Produto PRIMARY KEY (ID_Produto)
);

CREATE TABLE FornecedorProduto (
    ID_Fornecedor INT,
    ID_Produto INT,
    CONSTRAINT PK_FornecedorProduto PRIMARY KEY (ID_Fornecedor, ID_Produto),
    CONSTRAINT FK_FornecedorProduto_Fornecedor FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor),
    CONSTRAINT FK_FornecedorProduto_Produto FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);

INSERT Usuario (NomeCompleto, Usuario, Senha, Adm)
VALUES
		('admin', 'admin', 'admin', 1),
		('Guilherme Cella', 'GuiCella', '1234', 1)

INSERT INTO Cidade (Descricao, UF)
VALUES 
		('Erechim', 'RS'),
		('Porto Alegre', 'RS'),
		('S�o Paulo', 'SP'),
		('Rio de Janeiro', 'RJ'),
		('Curitiba', 'PR'),
		('Florian�polis', 'SC'),
		('Belo Horizonte', 'MG'),
		('Brasilia', 'DF'),
		('Salvador', 'BA'),
		('Fortaleza', 'CE');

INSERT INTO Fornecedor (NomeRazaoSocial, CNPJ, Endereco, Telefone, ID_Cidade)
VALUES
		('Fornecedor ABC', '12345678000199', 'Rua das Flores, 100', '51999990001', 1),  -- Erechim
		('Fornecedor XYZ', '98765432000188', 'Av. Central, 200', '51999990002', 2);     -- Porto Alegre

INSERT INTO Cliente (Nome, Sobrenome, CPF, Telefone, Endereco, ID_Cidade)
VALUES
		('Joao', 'Silva', '12345678901', '51999991111', 'Rua Verde, 50', 3),    -- S�o Paulo
		('Maria', 'Oliveira', '98765432100', '51999992222', 'Av. Paulista, 101', 4);  -- Rio de Janeiro

INSERT INTO Produto (CodigoMarca, Cor, Descricao, Tamanho, Genero)
VALUES
		(NULL, 'Azul', 'Camiseta Basica', 'M', 'Masculino'),  -- Produto sem C�digo de Marca
		('001', 'Preto', 'Calca Jeans', 'G', 'Feminino'),
		('002', 'Vermelho', 'Vestido Longo', 'P', 'Feminino'),
		('003', 'Branco', 'Tenis Esportivo', '42', 'Masculino'),
		(NULL, 'Verde', 'Jaqueta de Couro', 'GG', 'Unissex');  -- Produto sem C�digo de Marca