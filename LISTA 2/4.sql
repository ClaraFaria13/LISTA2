CREATE DATABASE db_prontuario_exam;
USE db_prontuario_exam;

CREATE TABLE pacientes (
   paciente_id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(100) NOT NULL,
   data_nascimento DATE,
   sexo VARCHAR(10),
   telefone VARCHAR(15),
   endereco TEXT,
   data_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE prontuarios (
   prontuario_id INT AUTO_INCREMENT PRIMARY KEY,
   paciente_id INT NOT NULL,
   data_consulta DATETIME DEFAULT CURRENT_TIMESTAMP,
   medico VARCHAR(100),
   diagnostico TEXT,
   prescricao TEXT,
   observacoes TEXT,
   FOREIGN KEY (paciente_id) REFERENCES pacientes(paciente_id)
);

CREATE TABLE consultas (
   consulta_id INT AUTO_INCREMENT PRIMARY KEY,
   paciente_id INT NOT NULL,
   medico VARCHAR(100),
   data_consulta DATETIME DEFAULT CURRENT_TIMESTAMP,
   motivo TEXT,
   FOREIGN KEY (paciente_id) REFERENCES pacientes(paciente_id)
);

-- Inserindo pacientes
INSERT INTO pacientes (nome, data_nascimento, sexo, telefone, endereco) VALUES
('Ana Lima', '1985-04-23', 'Feminino', '11911111111', 'Rua G, 101'),
('Bruno Souza', '1978-11-10', 'Masculino', '11822222222', 'Rua H, 202'),
('Carla Mendes', '1990-08-30', 'Feminino', '11733333333', 'Rua I, 303');

-- Inserindo prontuários
INSERT INTO prontuarios (paciente_id, medico, diagnostico, prescricao, observacoes) VALUES
(1, 'Dr. Silva', 'Gripe', 'Antitérmicos e repouso', 'Paciente deve retornar em 7 dias'),
(2, 'Dra. Pereira', 'Hipertensão', 'Controle da pressão e mudança de dieta', 'Acompanhamento mensal necessário'),
(3, 'Dr. Santos', 'Enxaqueca', 'Analgésicos e redução de estresse', 'Recomendado exame neurológico');

-- Inserindo consultas
INSERT INTO consultas (paciente_id, medico, motivo) VALUES
(1, 'Dr. Silva', 'Consulta de retorno após tratamento de gripe'),
(2, 'Dra. Pereira', 'Primeira consulta de acompanhamento da hipertensão'),
(3, 'Dr. Santos', 'Consulta inicial para avaliação de enxaqueca crônica');

4. Saúde e Gestão de Prontuários Eletrônicos
1. Exercício 1:
Crie uma consulta que recupere todos os prontuários, incluindo o nome do
paciente e o nome do médico que o atendeu. Utilize INNER JOIN entre as
tabelas de prontuários e pacientes.

*SELECT prontuarios.prontuario_id, pacientes.nome AS nome_paciente, prontuarios.medico, prontuarios.diagnostico, prontuarios.prescricao, prontuarios.observacoes
FROM prontuarios
INNER JOIN pacientes ON prontuarios.paciente_id = pacientes.paciente_id;*

2. Exercício 2:
Elabore uma consulta para listar todos os pacientes e suas consultas,
incluindo pacientes que não têm consultas registradas. Utilize LEFT JOIN
entre as tabelas de pacientes e consultas.

*SELECT pacientes.nome AS nome_paciente, consultas.medico, consultas.motivo, consultas.data_consulta
FROM pacientes
LEFT JOIN consultas ON pacientes.paciente_id = consultas.paciente_id;*

3. Exercício 3:
Desenvolva uma consulta que liste todas as consultas, incluindo o nome
do paciente e o motivo da consulta. Utilize INNER JOIN entre as tabelas de
consultas e pacientes.

*SELECT consultas.consulta_id, pacientes.nome AS nome_paciente, consultas.motivo, consultas.data_consulta
FROM consultas
INNER JOIN pacientes ON consultas.paciente_id = pacientes.paciente_id;*

4. Exercício 4:
Crie uma consulta para exibir todos os pacientes e os prontuários
relacionados, incluindo pacientes sem prontuários. Utilize LEFT JOIN entre
as tabelas de pacientes e prontuários.

*SELECT pacientes.nome AS nome_paciente, prontuarios.medico, prontuarios.diagnostico, prontuarios.prescricao, prontuarios.data_consulta
FROM pacientes
LEFT JOIN prontuarios ON pacientes.paciente_id = prontuarios.paciente_id;*

5. Exercício 5:
Escreva uma consulta para listar todos os prontuários, incluindo os
detalhes da consulta (como médico e data) se houver. Utilize LEFT JOIN
entre as tabelas de prontuários e consultas.

*SELECT prontuarios.prontuario_id, prontuarios.medico, prontuarios.diagnostico, prontuarios.prescricao, consultas.data_consulta AS data_consulta_relacionada
FROM prontuarios
LEFT JOIN consultas ON prontuarios.paciente_id = consultas.paciente_id;*

6. Exercício 6: Desenvolva uma consulta que liste todos os pacientes e o
número total de consultas que cada um teve. Inclua pacientes que não
tiveram consultas registradas. Utilize LEFT JOIN entre as tabelas de
pacientes e consultas.

*SELECT pacientes.nome AS nome_paciente, COUNT(consultas.consulta_id) AS total_consultas
FROM pacientes
LEFT JOIN consultas ON pacientes.paciente_id = consultas.paciente_id
GROUP BY pacientes.paciente_id;*