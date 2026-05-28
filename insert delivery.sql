INSERT INTO RESTAURANTES (nom_rest, cid_rest, end_rest) VALUES 
('Pizzaria Italia', 'São Miguel do Oeste', 'Rua XV de Novembro'),
('Trattoria Carbone', 'Florianopolis', 'Rua Felipe Schmidt');

INSERT INTO CLIENTES (nom_cliente, end_cliente, bairro, cidade) VALUES 
('João Silva', 'Rua 7 de Setembro', 'Centro', 'São Miguel do Oeste'),
('Ernesto Rivero', 'Rua Chui', 'Agostini', 'São Miguel do Oeste');

INSERT INTO PRODUTOS (nom_prod, id_rest) VALUES 
('Pizza Margatita', 1),
('Frango Asado', 2);


INSERT INTO ENTREGADORES ( nom_entregador, bairro_de_entrega) VALUES 
('Carlos Rodriguez', 'Centro'),
('Raul Rivero', 'Agostini');

INSERT INTO PEDIDOS (data_hora_pedido, status, id_cliente, id_entregador) VALUES 
('2026-05-20 19:30:05', 'Preparando', 1, 1 ),
('2026-05-20 20:45:15', 'Entregue', 2, 2);

INSERT INTO ITEM_PEDIDOS (quantidade, id_pedido, id_prod) VALUES 
(1, 1, 2),
(2, 2, 1);

