CREATE TABLE RESTAURANTES (
    id_rest SERIAL PRIMARY KEY NOT NULL,
    nom_rest VARCHAR(100) NOT NULL,
    cid_rest VARCHAR(50),
    end_rest VARCHAR(150)
);

CREATE TABLE CLIENTES (
    id_cliente SERIAL PRIMARY KEY NOT NULL,
    nom_cliente VARCHAR(100) NOT NULL,
    end_cliente VARCHAR(150),
    bairro VARCHAR(50),
	cidade VARCHAR(50)
);

CREATE TABLE PRODUTOS (
    id_prod SERIAL PRIMARY KEY,
    nom_prod VARCHAR(100) NOT NULL,
	id_rest INT NOT NULL,

	CONSTRAINT FK_PRODUTOS_RESTAURANTES
	FOREIGN KEY (id_rest)
	REFERENCES restaurantes(id_rest)
);

CREATE TABLE ENTREGADORES (
    id_entregador SERIAL PRIMARY KEY NOT NULL,
    nom_entregador VARCHAR(100),
    bairro_de_entrega VARCHAR(50)
);

CREATE TABLE PEDIDOS (
    id_pedido SERIAL PRIMARY KEY,
	data_hora_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	status VARCHAR(30), 
    id_cliente INT NOT NULL, 
    id_entregador INT NOT NULL,

	CONSTRAINT FK_PEDIDOS_CLIENTES
	FOREIGN KEY (id_cliente)
	REFERENCES clientes(id_cliente),

	CONSTRAINT FK_PEDIDOS_ENTREGADODES
	FOREIGN KEY (id_entregador)
	REFERENCES Entregadores(id_entregador)
        
);

CREATE TABLE ITEM_PEDIDOS (
    id_item_pedido INT PRIMARY KEY NOT NULL, 
	quantidade INT,
	id_pedido INT NOT NULL,
    id_prod INT NOT NULL,

	CONSTRAINT FK_ITEM_PEDIDOS_PEDIDOS
		FOREIGN KEY (id_pedido)
		REFERENCES pedidos(id_pedido),

	CONSTRAINT FK_ITEM_PEDIDOS_PRODUTOS
		FOREIGN KEY (id_prod)
		REFERENCES produtos(id_prod)
	     
);


