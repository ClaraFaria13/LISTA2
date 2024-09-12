CREATE DATABASE db_crm_exam;
USE db_crm_exam;
CREATE TABLE clientes (
   cliente_id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   email VARCHAR(100) UNIQUE NOT NULL,
   telefone VARCHAR(15),
   endereco TEXT,
   data_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE interacoes (
   interacao_id INT AUTO_INCREMENT PRIMARY KEY,
   cliente_id INT NOT NULL,
   tipo VARCHAR(50),
   data_interacao DATETIME DEFAULT CURRENT_TIMESTAMP,
   detalhes TEXT,
   FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE campanhas (
   campanha_id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   descricao TEXT,
   data_inicio DATE,
   data_fim DATE
);

CREATE TABLE participacoes_campanha (
   participacao_id INT AUTO_INCREMENT PRIMARY KEY,
   cliente_id INT NOT NULL,
   campanha_id INT NOT NULL,
   data_participacao DATETIME DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
   FOREIGN KEY (campanha_id) REFERENCES campanhas(campanha_id)
);

-- Inserindo clientes
INSERT INTO clientes (nome, email, telefone, endereco) VALUES
('Lucas Andrade', 'lucas.andrade@email.com', '11555555555', 'Avenida D, 1001'),
('Fernanda Costa', 'fernanda.costa@email.com', '11666666666', 'Rua E, 202'),
('Renata Souza', 'renata.souza@email.com', '11777777777', 'Rua F, 303');

-- Inserindo interações
INSERT INTO interacoes (cliente_id, tipo, detalhes) VALUES
(1, 'Telefone', 'Ligação para esclarecimento sobre produto'),
(2, 'Email', 'Enviado e-mail promocional da campanha de verão'),
(3, 'Chat', 'Suporte técnico solicitado via chat online');

-- Inserindo campanhas
INSERT INTO campanhas (nome, descricao, data_inicio, data_fim) VALUES
('Campanha Verão 2024', 'Descontos especiais para produtos de verão', '2024-01-01', '2024-03-31'),
('Campanha Black Friday', 'Ofertas de Black Friday 2024', '2024-11-25', '2024-11-30');

-- Inserindo participações em campanhas
INSERT INTO participacoes_campanha (cliente_id, campanha_id) VALUES
(1, 1),
(2, 2),
(3, 1);

2. Sistema de Gestão de Relacionamento com o Cliente (CRM)
1. Exercício 1:
Crie uma consulta que recupere todos os clientes e as interações que eles
tiveram. Utilize LEFT JOIN para incluir todos os clientes, mesmo aqueles
sem interações.

*SELECT clientes.cliente_id, clientes.nome, interacoes.tipo, interacoes.detalhes
FROM clientes
LEFT JOIN interacoes ON clientes.cliente_id = interacoes.cliente_id;*

2. Exercício 2:
Desenvolva uma consulta que liste todas as campanhas e os clientes que
participaram delas. Utilize INNER JOIN para combinar as tabelas de
campanhas e participações de campanha.

*SELECT campanhas.nome AS campanha_nome, clientes.nome AS cliente_nome
FROM campanhas
INNER JOIN participacoes_campanha ON campanhas.campanha_id = participacoes_campanha.campanha_id
INNER JOIN clientes ON participacoes_campanha.cliente_id = clientes.cliente_id;*

3. Exercício 3:
Elabore uma consulta para obter todos os clientes, incluindo os que não
participaram de nenhuma campanha. Utilize LEFT JOIN entre as tabelas de
clientes e participações de campanha.

*SELECT clientes.nome, campanhas.nome AS campanha_nome
FROM clientes
LEFT JOIN participacoes_campanha ON clientes.cliente_id = participacoes_campanha.cliente_id
LEFT JOIN campanhas ON participacoes_campanha.campanha_id = campanhas.campanha_id;*

4. Exercício 4:
Escreva uma consulta para listar todos os clientes e as campanhas que
participaram, mesmo que não haja clientes associados a uma campanha
específica. Utilize RIGHT JOIN entre as tabelas de clientes e campanhas.

*SELECT clientes.nome AS cliente_nome, campanhas.nome AS campanha_nome
FROM clientes
RIGHT JOIN participacoes_campanha ON clientes.cliente_id = participacoes_campanha.cliente_id
RIGHT JOIN campanhas ON participacoes_campanha.campanha_id = campanhas.campanha_id;*

5. Exercício 5:
Crie uma consulta para exibir os detalhes de todas as interações feitas por
clientes, incluindo o nome do cliente, o tipo de interação e os detalhes.
Utilize INNER JOIN para associar as tabelas de interações e clientes.

*SELECT clientes.nome, interacoes.tipo, interacoes.detalhes
FROM interacoes
INNER JOIN clientes ON interacoes.cliente_id = clientes.cliente_id;*

6. Exercício 6: Crie uma consulta que liste todas as campanhas e o número
total de clientes que participaram de cada campanha. Inclua campanhas
que não tiveram participações. Utilize LEFT JOIN entre as tabelas de
campanhas e participações de campanha.

*SELECT campanhas.nome AS campanha_nome, COUNT(participacoes_campanha.cliente_id) AS total_participantes
FROM campanhas
LEFT JOIN participacoes_campanha ON campanhas.campanha_id = participacoes_campanha.campanha_id
GROUP BY campanhas.campanha_id;*