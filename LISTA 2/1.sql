CREATE DATABASE db_ecommerce_exam;
USE db_ecommerce_exam;
CREATE TABLE produtos (
   produto_id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   descricao TEXT,
   preco DECIMAL(10, 2) NOT NULL,
   estoque INT NOT NULL,
   data_adicionado DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clientes (
   cliente_id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   email VARCHAR(100) UNIQUE NOT NULL,
   telefone VARCHAR(15),
   endereco TEXT,
   data_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pedidos (
   pedido_id INT AUTO_INCREMENT PRIMARY KEY,
   cliente_id INT NOT NULL,
   data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
   total DECIMAL(10, 2) NOT NULL,
   status VARCHAR(50),
   FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE itens_pedido (
   item_pedido_id INT AUTO_INCREMENT PRIMARY KEY,
   pedido_id INT NOT NULL,
   produto_id INT NOT NULL,
   quantidade INT NOT NULL,
   preco_unitario DECIMAL(10, 2) NOT NULL,
   FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
   FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);

-- Inserindo produtos
INSERT INTO produtos (nome, descricao, preco, estoque) VALUES
('Smartphone XYZ', 'Smartphone com 128GB de armazenamento', 1200.00, 50),
('Notebook ABC', 'Notebook com 16GB RAM e 512GB SSD', 3500.00, 30),
('Tablet DEF', 'Tablet com tela de 10 polegadas', 800.00, 40);

-- Inserindo clientes
INSERT INTO clientes (nome, email, telefone, endereco) VALUES
('João da Silva', 'joao.silva@email.com', '11999999999', 'Rua A, 123'),
('Maria Oliveira', 'maria.oliveira@email.com', '11888888888', 'Rua B, 456'),
('Carlos Pereira', 'carlos.pereira@email.com', '11777777777', 'Rua C, 789');

-- Inserindo pedidos
INSERT INTO pedidos (cliente_id, total, status) VALUES
(1, 2400.00, 'Processando'),
(2, 800.00, 'Enviado'),
(3, 3500.00, 'Entregue');

-- Inserindo itens dos pedidos
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 2, 1200.00),
(2, 3, 1, 800.00),
(3, 2, 1, 3500.00);

1. E-commerce e Gestão de Inventário
1. Exercício 1:
Escreva uma consulta SQL que recupere todos os pedidos juntamente com
o nome e o email dos clientes que fizeram esses pedidos. Utilize INNER
JOIN para combinar as tabelas de pedidos e clientes.

*SELECT pedidos.pedido_id, clientes.nome, clientes.email, pedidos.total, pedidos.status
FROM pedidos
INNER JOIN clientes ON pedidos.cliente_id = clientes.cliente_id;*

2. Exercício 2:
Crie uma consulta para listar todos os produtos e, caso existam, os
detalhes dos pedidos em que esses produtos foram vendidos. Utilize LEFT
JOIN para incluir todos os produtos, mesmo aqueles que não foram
vendidos.

*SELECT produtos.produto_id, produtos.nome, produtos.descricao, itens_pedido.quantidade, itens_pedido.preco_unitario
FROM produtos
LEFT JOIN itens_pedido ON produtos.produto_id = itens_pedido.produto_id;*

3. Exercício 3:
Desenvolva uma consulta para obter o nome do cliente e o total do pedido
para todos os pedidos realizados, incluindo clientes que possam não ter
nenhum pedido associado. Use LEFT JOIN.

*SELECT clientes.nome, pedidos.total
FROM clientes
LEFT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;*

4. Exercício 4:
Escreva uma consulta para listar todos os itens de pedido junto com o
nome dos produtos. Utilize INNER JOIN para combinar as tabelas de itens
de pedido e produtos.

*SELECT itens_pedido.item_pedido_id, produtos.nome, itens_pedido.quantidade, itens_pedido.preco_unitario
FROM itens_pedido
INNER JOIN produtos ON itens_pedido.produto_id = produtos.produto_id;*

5. Exercício 5:
Elabore uma consulta para exibir todos os clientes e seus pedidos, mas
também inclua clientes que ainda não fizeram pedidos. Utilize LEFT JOIN
entre as tabelas de clientes e pedidos.

*SELECT clientes.nome, pedidos.pedido_id, pedidos.total
FROM clientes
LEFT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id;*

6. Exercício 6: Elabore uma consulta para exibir os detalhes de cada pedido
(pedido_id, nome do cliente, total do pedido) e todos os itens do pedido
(nome do produto, quantidade, preço unitário). Utilize INNER JOIN para
combinar as tabelas de pedidos, clientes e itens de pedido.

*SELECT pedidos.pedido_id, clientes.nome AS nome_cliente, pedidos.total, produtos.nome AS nome_produto, itens_pedido.quantidade, itens_pedido.preco_unitario
FROM pedidos
INNER JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
INNER JOIN itens_pedido ON pedidos.pedido_id = itens_pedido.pedido_id
INNER JOIN produtos ON itens_pedido.produto_id = produtos.produto_id;*