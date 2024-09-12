CREATE DATABASE db_financas_exam;
USE db_financas_exam;

CREATE TABLE contas (
   conta_id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   tipo VARCHAR(50),
   saldo DECIMAL(15, 2) DEFAULT 0.00,
   data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transacoes (
   transacao_id INT AUTO_INCREMENT PRIMARY KEY,
   conta_id INT NOT NULL,
   tipo VARCHAR(50),
   valor DECIMAL(15, 2) NOT NULL,
   data_transacao DATETIME DEFAULT CURRENT_TIMESTAMP,
   descricao TEXT,
   FOREIGN KEY (conta_id) REFERENCES contas(conta_id)
);

CREATE TABLE orcamentos (
   orcamento_id INT AUTO_INCREMENT PRIMARY KEY,
   categoria VARCHAR(100),
   valor_planejado DECIMAL(15, 2) NOT NULL,
   data_inicio DATE,
   data_fim DATE
);

-- Inserindo contas
INSERT INTO contas (nome, tipo, saldo) VALUES
('Conta Corrente', 'Conta Corrente', 5000.00),
('Poupança', 'Conta Poupança', 12000.00),
('Investimentos', 'Conta Investimento', 20000.00);

-- Inserindo transações
INSERT INTO transacoes (conta_id, tipo, valor, descricao) VALUES
(1, 'Débito', 1000.00, 'Pagamento de aluguel'),
(2, 'Crédito', 1500.00, 'Depósito mensal'),
(3, 'Crédito', 5000.00, 'Rendimento de investimentos');

-- Inserindo orçamentos
INSERT INTO orcamentos (categoria, valor_planejado, data_inicio, data_fim) VALUES
('Alimentação', 2000.00, '2024-01-01', '2024-01-31'),
('Transporte', 800.00, '2024-01-01', '2024-01-31'),
('Lazer', 1000.00, '2024-01-01', '2024-01-31');

3. Finanças e Controle Orçamentário
1. Exercício 1:
Escreva uma consulta que liste todas as transações junto com o nome da
conta associada a cada transação. Utilize INNER JOIN para combinar as
tabelas de transações e contas.

*SELECT transacoes.transacao_id, contas.nome AS nome_conta, transacoes.tipo, transacoes.valor, transacoes.descricao, transacoes.data_transacao
FROM transacoes
INNER JOIN contas ON transacoes.conta_id = contas.conta_id;*

2. Exercício 2:
Desenvolva uma consulta para obter todas as contas e suas transações,
incluindo contas que ainda não têm transações registradas. Utilize LEFT
JOIN entre as tabelas de contas e transações.

*SELECT contas.nome AS nome_conta, transacoes.tipo, transacoes.valor, transacoes.descricao
FROM contas
LEFT JOIN transacoes ON contas.conta_id = transacoes.conta_id;*

3. Exercício 3:
Crie uma consulta para listar todas as transações com a categoria do
orçamento associada, se houver. Utilize LEFT JOIN para incluir todas as
transações.

*SELECT transacoes.transacao_id, transacoes.tipo, transacoes.valor, orcamentos.categoria
FROM transacoes
LEFT JOIN orcamentos ON transacoes.descricao LIKE CONCAT('%', orcamentos.categoria, '%');*

4. Exercício 4:
Elabore uma consulta para exibir todos os orçamentos e as transações
relacionadas a eles, incluindo orçamentos que não possuem transações
associadas. Utilize RIGHT JOIN.

*SELECT orcamentos.categoria, transacoes.transacao_id, transacoes.valor, transacoes.descricao
FROM transacoes
RIGHT JOIN orcamentos ON transacoes.descricao LIKE CONCAT('%', orcamentos.categoria, '%');*

5. Exercício 5:
Crie uma consulta para obter o nome da conta, tipo de conta, tipo de
transação e o valor para todas as transações, utilizando INNER JOIN entre
as tabelas de contas e transações.

*SELECT contas.nome AS nome_conta, contas.tipo AS tipo_conta, transacoes.tipo AS tipo_transacao, transacoes.valor
FROM transacoes
INNER JOIN contas ON transacoes.conta_id = contas.conta_id;*

6. Exercício 6: Escreva uma consulta que mostre o saldo total de todas as
contas, bem como o número total de transações associadas a cada conta.
Inclua contas que não têm transações. Utilize LEFT JOIN entre as tabelas
de contas e transações. 

*SELECT contas.nome AS nome_conta, contas.saldo, COUNT(transacoes.transacao_id) AS total_transacoes
FROM contas
LEFT JOIN transacoes ON contas.conta_id = transacoes.conta_id
GROUP BY contas.conta_id;*