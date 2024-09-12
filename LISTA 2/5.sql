CREATE DATABASE db_logistica_exam;
USE db_logistica_exam;

CREATE TABLE fornecedores (
   fornecedor_id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   contato VARCHAR(100),
   telefone VARCHAR(15),
   endereco TEXT
);

CREATE TABLE produtos (
   produto_id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   descricao TEXT,
   preco DECIMAL(10, 2) NOT NULL,
   fornecedor_id INT,
   estoque INT NOT NULL,
   FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(fornecedor_id)
);

CREATE TABLE armazens (
   armazem_id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   localizacao VARCHAR(100)
);

CREATE TABLE movimentacao_estoque (
   movimentacao_id INT AUTO_INCREMENT PRIMARY KEY,
   produto_id INT NOT NULL,
   armazem_id INT NOT NULL,
   quantidade INT NOT NULL,
   tipo_movimentacao VARCHAR(50),
   data_movimentacao DATETIME DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (produto_id) REFERENCES produtos(produto_id),
   FOREIGN KEY (armazem_id) REFERENCES armazens(armazem_id)
);

CREATE TABLE entregas (
   entrega_id INT AUTO_INCREMENT PRIMARY KEY,
   produto_id INT NOT NULL,
   quantidade INT NOT NULL,
   endereco_entrega TEXT,
   data_entrega DATETIME,
   status VARCHAR(50),
   FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);

-- Inserindo fornecedores
INSERT INTO fornecedores (nome, contato, telefone, endereco) VALUES
('Fornecedor A', 'Carlos Lima', '11444444444', 'Av. J, 1000'),
('Fornecedor B', 'Mariana Costa', '11333333333', 'Rua K, 500'),
('Fornecedor C', 'Renato Santos', '11222222222', 'Rua L, 300');

-- Inserindo produtos
INSERT INTO produtos (nome, descricao, preco, fornecedor_id, estoque) VALUES
('Produto X', 'Descrição do produto X', 100.00, 1, 100),
('Produto Y', 'Descrição do produto Y', 200.00, 2, 50),
('Produto Z', 'Descrição do produto Z', 150.00, 3, 75);

-- Inserindo armazéns
INSERT INTO armazens (nome, localizacao) VALUES
('Armazém Central', 'Centro'),
('Armazém Norte', 'Zona Norte'),
('Armazém Sul', 'Zona Sul');

-- Inserindo movimentações de estoque
INSERT INTO movimentacao_estoque (produto_id, armazem_id, quantidade, tipo_movimentacao) VALUES
(1, 1, 50, 'Entrada'),
(2, 2, 30, 'Saída'),
(3, 3, 20, 'Entrada');

-- Inserindo entregas
INSERT INTO entregas (produto_id, quantidade, endereco_entrega, data_entrega, status) VALUES
(1, 10, 'Rua M, 120', '2024-09-15', 'Enviado'),
(2, 5, 'Rua N, 220', '2024-09-16', 'Entregue'),
(3, 15, 'Rua O, 320', '2024-09-17', 'Pendente');

5. Logística e Cadeia de Suprimentos
1. Exercício 1:
Crie uma consulta para listar todos os produtos e seus fornecedores,
incluindo produtos sem fornecedores. Utilize LEFT JOIN entre as tabelas de
produtos e fornecedores.

*SELECT produtos.nome AS nome_produto, produtos.descricao, fornecedores.nome AS nome_fornecedor
FROM produtos
LEFT JOIN fornecedores ON produtos.fornecedor_id = fornecedores.fornecedor_id;*

2. Exercício 2:
Desenvolva uma consulta que recupere todos os movimentos de estoque e
o nome do produto associado a cada movimento. Utilize INNER JOIN entre
as tabelas de movimentação de estoque e produtos.

*SELECT movimentacao_estoque.movimentacao_id, produtos.nome AS nome_produto, movimentacao_estoque.quantidade, movimentacao_estoque.tipo_movimentacao, movimentacao_estoque.data_movimentacao
FROM movimentacao_estoque
INNER JOIN produtos ON movimentacao_estoque.produto_id = produtos.produto_id;*

3. Exercício 3:
Escreva uma consulta para obter todos os armazéns e os movimentos de
estoque realizados neles, incluindo armazéns sem movimentos
registrados. Utilize LEFT JOIN entre as tabelas de armazéns e
movimentação de estoque.

*SELECT armazens.nome AS nome_armazem, movimentacao_estoque.quantidade, movimentacao_estoque.tipo_movimentacao, movimentacao_estoque.data_movimentacao
FROM armazens
LEFT JOIN movimentacao_estoque ON armazens.armazem_id = movimentacao_estoque.armazem_id;*

4. Exercício 4:
Elabore uma consulta para listar todos os produtos e suas entregas,
incluindo produtos que ainda não foram entregues. Utilize LEFT JOIN entre
as tabelas de produtos e entregas.

*SELECT produtos.nome AS nome_produto, entregas.quantidade, entregas.endereco_entrega, entregas.data_entrega, entregas.status
FROM produtos
LEFT JOIN entregas ON produtos.produto_id = entregas.produto_id;*

5. Exercício 5:
Crie uma consulta para exibir todos os fornecedores e os produtos
fornecidos por eles, incluindo fornecedores que não forneceram produtos.
Utilize LEFT JOIN entre as tabelas de fornecedores e produtos.

*SELECT fornecedores.nome AS nome_fornecedor, produtos.nome AS nome_produto, produtos.descricao
FROM fornecedores
LEFT JOIN produtos ON fornecedores.fornecedor_id = produtos.fornecedor_id;*

6. Exercício 6: Escreva uma consulta que recupere todos os produtos e a
quantidade total disponível em todos os armazéns. Inclua produtos que
não têm movimentações de estoque. Utilize LEFT JOIN entre as tabelas de
produtos e movimentação de estoque.

*SELECT produtos.nome AS nome_produto, COALESCE(SUM(movimentacao_estoque.quantidade), 0) AS total_estoque
FROM produtos
LEFT JOIN movimentacao_estoque ON produtos.produto_id = movimentacao_estoque.produto_id
GROUP BY produtos.produto_id;*