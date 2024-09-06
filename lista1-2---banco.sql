-- Lista 1

-- Exercício 1 = Listar todos os pedidos com detalhes do cliente Escreva uma consulta SQL que retorne o ID do pedido, a data do pedido, o nome completo do cliente e o email para todos os pedidos. Use um JOIN para combinar as tabelas Orders e Customers.

SELECT o.order_id, o.order_date, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;

-- Exercício 2 = Encontrar todos os produtos pedidos por um cliente específico Escreva uma consulta SQL que retorne o nome do produto e a quantidade pedida para todos os produtos pedidos por um cliente com um customer_id específico (por exemplo, customer_id = 1). Essa consulta deve combinar as tabelas Order_Items, Orders e Products.

SELECT p.product_name, oi.quantity
FROM Order_Items oi
INNER JOIN Orders o ON oi.order_id = o.order_id
INNER JOIN Products p ON oi.product_id = p.product_id
WHERE o.customer_id = 1;  -- Colocar o id que você quiser

-- Exercício 3 = Calcular o total gasto por cada cliente Escreva uma consulta SQL que calcule o total gasto por cada cliente. O resultado deve incluir o nome completo do cliente e o total gasto. Essa consulta deve usar JOINs para combinar as tabelas Customers, Orders, Order_Items e Products, e deve usar uma função de agregação para calcular o total.

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(oi.quantity * p.price) AS total_spent
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name;


-- Exercício 4 = Encontrar os clientes que nunca fizeram um pedido Escreva uma consulta SQL que retorne os nomes dos clientes que nunca fizeram um pedido. Para isso, use um LEFT JOIN entre as tabelas Customers e Orders e filtre os resultados para encontrar clientes sem pedidos.

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Exercício 5 = Listar os produtos mais vendidos Escreva uma consulta SQL que retorne o nome do produto e a quantidade total vendida, ordenando os resultados pelos produtos mais vendidos. Combine as tabelas Order_Items e Products, e utilize uma função de agregação para somar a quantidade vendida de cada produto.

SELECT p.product_name, SUM(oi.quantity) AS total_quantity_sold
FROM Order_Items oi
INNER JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC;

-- Lista 2 

-- E-commerce e Gestão de Inventário

-- Exercício 1 = Escreva uma consulta SQL que recupere todos os pedidos juntamente com o nome e o email dos clientes que fizeram esses pedidos. Utilize INNER JOIN para combinar as tabelas de pedidos e clientes.

SELECT p.pedido_id, c.nome, c.email
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.cliente_id;

-- Exercício 2 = Crie uma consulta para listar todos os produtos e, caso existam, os detalhes dos pedidos em que esses produtos foram vendidos. Utilize LEFT JOIN para incluir todos os produtos, mesmo aqueles que não foram vendidos.

SELECT pr.produto_id, pr.nome AS produto_nome, pr.descricao, p.pedido_id, p.data_pedido
FROM produtos pr
LEFT JOIN itens_pedido ip ON pr.produto_id = ip.produto_id
LEFT JOIN pedidos p ON ip.pedido_id = p.pedido_id;


-- Exercício 3 = Desenvolva uma consulta para obter o nome do cliente e o total do pedido para todos os pedidos realizados, incluindo clientes que possam não ter nenhum pedido associado. Use LEFT JOIN.

SELECT c.nome AS cliente_nome, p.total AS total_pedido
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id;


-- Exercício 4 = Escreva uma consulta para listar todos os itens de pedido junto com o nome dos produtos. Utilize INNER JOIN para combinar as tabelas de itens de pedido e produtos.

SELECT ip.item_pedido_id, ip.pedido_id, pr.nome AS produto_nome, ip.quantidade, ip.preco_unitario
FROM itens_pedido ip
INNER JOIN produtos pr ON ip.produto_id = pr.produto_id;


-- Exercício 5 = Elabore uma consulta para exibir todos os clientes e seus pedidos, mas também inclua clientes que ainda não fizeram pedidos. Utilize LEFT JOIN entre as tabelas de clientes e pedidos.

SELECT c.cliente_id, c.nome, p.pedido_id, p.data_pedido
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id;


-- Exercício 6 = Elabore uma consulta para exibir os detalhes de cada pedido (pedido_id, nome do cliente, total do pedido) e todos os itens do pedido (nome do produto, quantidade, preço unitário). Utilize INNER JOIN para combinar as tabelas de pedidos, clientes e itens de pedido.

SELECT p.pedido_id, c.nome AS cliente_nome, p.total AS total_pedido, pr.nome AS produto_nome, ip.quantidade, ip.preco_unitario
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.cliente_id
INNER JOIN itens_pedido ip ON p.pedido_id = ip.pedido_id
INNER JOIN produtos pr ON ip.produto_id = pr.produto_id;


-- Sistema de Gestão de Relacionamento com o Cliente (CRM)

-- Exercício 1 = Crie uma consulta que recupere todos os clientes e as interações que eles tiveram. Utilize LEFT JOIN para incluir todos os clientes, mesmo aqueles sem interações.
SELECT c.cliente_id, c.nome AS cliente_nome, i.tipo, i.detalhes
FROM clientes c
LEFT JOIN interacoes i ON c.cliente_id = i.cliente_id;


-- Exercício 2 = Desenvolva uma consulta que liste todas as campanhas e os clientes que participaram delas. Utilize INNER JOIN para combinar as tabelas de campanhas e participações de campanha.

SELECT camp.campanha_id, camp.nome AS campanha_nome, c.nome AS cliente_nome
FROM campanhas camp
INNER JOIN participacoes_campanha pc ON camp.campanha_id = pc.campanha_id
INNER JOIN clientes c ON pc.cliente_id = c.cliente_id;

-- Exercício 3 = Elabore uma consulta para obter todos os clientes, incluindo os que não participaram de nenhuma campanha. Utilize LEFT JOIN entre as tabelas de clientes e participações de campanha.

SELECT c.cliente_id, c.nome AS cliente_nome, camp.nome AS campanha_nome
FROM clientes c
LEFT JOIN participacoes_campanha pc ON c.cliente_id = pc.cliente_id
LEFT JOIN campanhas camp ON pc.campanha_id = camp.campanha_id;


-- Exercício 4 = Escreva uma consulta para listar todos os clientes e as campanhas que participaram, mesmo que não haja clientes associados a uma campanha específica. Utilize RIGHT JOIN entre as tabelas de clientes e campanhas.

SELECT c.cliente_id, c.nome AS cliente_nome, camp.campanha_id, camp.nome AS campanha_nome
FROM clientes c
RIGHT JOIN participacoes_campanha pc ON c.cliente_id = pc.cliente_id
RIGHT JOIN campanhas camp ON pc.campanha_id = camp.campanha_id;


-- Exercício 5 = Crie uma consulta para exibir os detalhes de todas as interações feitas por clientes, incluindo o nome do cliente, o tipo de interação e os detalhes. Utilize INNER JOIN para associar as tabelas de interações e clientes.

SELECT c.nome AS cliente_nome, i.tipo AS tipo_interacao, i.detalhes
FROM interacoes i
INNER JOIN clientes c ON i.cliente_id = c.cliente_id;


-- Exercício 6 = Crie uma consulta que liste todas as campanhas e o número total de clientes que participaram de cada campanha. Inclua campanhas  que não tiveram participações. Utilize LEFT JOIN entre as tabelas de campanhas e participações de campanha.

SELECT camp.nome AS campanha_nome, COUNT(pc.cliente_id) AS total_clientes
FROM campanhas camp
LEFT JOIN participacoes_campanha pc ON camp.campanha_id = pc.campanha_id
GROUP BY camp.campanha_id, camp.nome;


-- Finanças e Controle Orçamentário

-- Exercício 1 = Escreva uma consulta que liste todas as transações junto com o nome da conta associada a cada transação. Utilize INNER JOIN para combinar as tabelas de transações e contas.
SELECT t.transacao_id, c.nome AS conta_nome, t.tipo AS tipo_transacao, t.valor, t.descricao
FROM transacoes t
INNER JOIN contas c ON t.conta_id = c.conta_id;


-- Exercício 2 = Desenvolva uma consulta para obter todas as contas e suas transações, incluindo contas que ainda não têm transações registradas. Utilize LEFT JOIN entre as tabelas de contas e transações.
SELECT c.nome AS conta_nome, t.transacao_id, t.tipo AS tipo_transacao, t.valor, t.descricao
FROM contas c
LEFT JOIN transacoes t ON c.conta_id = t.conta_id;


-- Exercício 3 = Crie uma consulta para listar todas as transações com a categoria do orçamento associada, se houver. Utilize LEFT JOIN para incluir todas as transações.

SELECT t.transacao_id, t.tipo AS tipo_transacao, t.valor, t.descricao, o.categoria
FROM transacoes t
LEFT JOIN orcamentos o ON t.orcamento_id = o.orcamento_id;

-- Exercício 4 = Elabore uma consulta para exibir todos os orçamentos e as transações relacionadas a eles, incluindo orçamentos que não possuem transações associadas. Utilize RIGHT JOIN.
SELECT o.categoria, o.valor_planejado, o.data_inicio, o.data_fim, t.transacao_id, t.tipo AS tipo_transacao, t.valor, t.descricao
FROM orcamentos o
RIGHT JOIN transacoes t ON o.orcamento_id = t.orcamento_id;


-- Exercício 5 = Crie uma consulta para obter o nome da conta, tipo de conta, tipo de transação e o valor para todas as transações, utilizando INNER JOIN entre as tabelas de contas e transações.
SELECT c.nome AS conta_nome, c.tipo AS tipo_conta, t.tipo AS tipo_transacao, t.valor
FROM transacoes t
INNER JOIN contas c ON t.conta_id = c.conta_id;


-- Exercício 6 = Escreva uma consulta que mostre o saldo total de todas as contas, bem como o número total de transações associadas a cada conta. Inclua contas que não têm transações. Utilize LEFT JOIN entre as tabelas de contas e transações.
SELECT c.nome AS conta_nome, c.saldo AS saldo_total, COUNT(t.transacao_id) AS total_transacoes
FROM contas c
LEFT JOIN transacoes t ON c.conta_id = t.conta_id
GROUP BY c.conta_id, c.nome, c.saldo;


--  Saúde e Gestão de Prontuários Eletrônicos

-- Exercício 1 = Crie uma consulta que recupere todos os prontuários, incluindo o nome do paciente e o nome do médico que o atendeu. Utilize INNER JOIN entre as tabelas de prontuários e pacientes.
SELECT p.nome AS paciente_nome, pr.medico, pr.diagnostico, pr.prescricao, pr.observacoes
FROM prontuarios pr
INNER JOIN pacientes p ON pr.paciente_id = p.paciente_id;


-- Exercício 2 = Elabore uma consulta para listar todos os pacientes e suas consultas, incluindo pacientes que não têm consultas registradas. Utilize LEFT JOIN entre as tabelas de pacientes e consultas.
SELECT p.nome AS paciente_nome, c.consulta_id, c.medico, c.data_consulta, c.motivo
FROM pacientes p
LEFT JOIN consultas c ON p.paciente_id = c.paciente_id;

-- Exercício 3 = Desenvolva uma consulta que liste todas as consultas, incluindo o nome do paciente e o motivo da consulta. Utilize INNER JOIN entre as tabelas de consultas e pacientes.
SELECT c.consulta_id, p.nome AS paciente_nome, c.medico, c.data_consulta, c.motivo
FROM consultas c
INNER JOIN pacientes p ON c.paciente_id = p.paciente_id;


-- Exercício 4 = Crie uma consulta para exibir todos os pacientes e os prontuários relacionados, incluindo pacientes sem prontuários. Utilize LEFT JOIN entre as tabelas de pacientes e prontuários.

SELECT p.nome AS paciente_nome, pr.prontuario_id, pr.data_consulta, pr.medico, pr.diagnostico, pr.prescricao, pr.observacoes
FROM pacientes p
LEFT JOIN prontuarios pr ON p.paciente_id = pr.paciente_id;

-- Exercício 5 = Escreva uma consulta para listar todos os prontuários, incluindo os detalhes da consulta (como médico e data) se houver. Utilize LEFT JOIN entre as tabelas de prontuários e consultas.
SELECT pr.prontuario_id, p.nome AS paciente_nome, pr.medico, pr.diagnostico, pr.prescricao, pr.observacoes, c.data_consulta
FROM prontuarios pr
LEFT JOIN consultas c ON pr.paciente_id = c.paciente_id AND c.data_consulta = pr.data_consulta;


-- Exercício 6 = Desenvolva uma consulta que liste todos os pacientes e o número total de consultas que cada um teve. Inclua pacientes que não tiveram consultas registradas. Utilize LEFT JOIN entre as tabelas de pacientes e consultas.
SELECT p.nome AS paciente_nome, COUNT(c.consulta_id) AS total_consultas
FROM pacientes p
LEFT JOIN consultas c ON p.paciente_id = c.paciente_id
GROUP BY p.paciente_id, p.nome;


--  Logística e Cadeia de Suprimentos

-- Exercício 1 = Crie uma consulta para listar todos os produtos e seus fornecedores, incluindo produtos sem fornecedores. Utilize LEFT JOIN entre as tabelas de produtos e fornecedores.
SELECT p.nome AS produto_nome, f.nome AS fornecedor_nome
FROM produtos p
LEFT JOIN fornecedores f ON p.fornecedor_id = f.fornecedor_id;



-- Exercício 2 = Desenvolva uma consulta que recupere todos os movimentos de estoque e o nome do produto associado a cada movimento. Utilize INNER JOIN entre as tabelas de movimentação de estoque e produtos.
SELECT me.movimentacao_id, p.nome AS produto_nome, me.quantidade, me.tipo_movimentacao, me.data_movimentacao
FROM movimentacao_estoque me
INNER JOIN produtos p ON me.produto_id = p.produto_id;


-- Exercício 3 = Escreva uma consulta para obter todos os armazéns e os movimentos de estoque realizados neles, incluindo armazéns sem movimentos registrados. Utilize LEFT JOIN entre as tabelas de armazéns e movimentação de estoque.
SELECT a.nome AS armazem_nome, me.movimentacao_id, me.produto_id, me.quantidade, me.tipo_movimentacao, me.data_movimentacao
FROM armazens a
LEFT JOIN movimentacao_estoque me ON a.armazem_id = me.armazem_id;


-- Exercício 4 = Elabore uma consulta para listar todos os produtos e suas entregas, incluindo produtos que ainda não foram entregues. Utilize LEFT JOIN entre as tabelas de produtos e entregas.
SELECT p.nome AS produto_nome, e.quantidade, e.endereco_entrega, e.data_entrega, e.status
FROM produtos p
LEFT JOIN entregas e ON p.produto_id = e.produto_id;


-- Exercício 5 = Crie uma consulta para exibir todos os fornecedores e os produtos fornecidos por eles, incluindo fornecedores que não forneceram produtos. Utilize LEFT JOIN entre as tabelas de fornecedores e produtos.

SELECT f.nome AS fornecedor_nome, p.nome AS produto_nome
FROM fornecedores f
LEFT JOIN produtos p ON f.fornecedor_id = p.fornecedor_id;

-- Exercício 6 = Escreva uma consulta que recupere todos os produtos e a quantidade total disponível em todos os armazéns. Inclua produtos que não têm movimentações de estoque. Utilize LEFT JOIN entre as tabelas de produtos e movimentação de estoque
SELECT p.nome AS produto_nome, COALESCE(SUM(me.quantidade), 0) AS quantidade_total
FROM produtos p
LEFT JOIN movimentacao_estoque me ON p.produto_id = me.produto_id
GROUP BY p.produto_id, p.nome;
