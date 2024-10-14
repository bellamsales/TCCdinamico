DROP PROCEDURE IF EXISTS ConsultarProdutos$$
CREATE PROCEDURE ConsultarProdutos()
BEGIN
    SELECT cd_produto, nm_produto, ds_produto_estoque, vl_produto_estoque,   qt_produto_estoque
    FROM Produto;
END $$

CREATE TABLE Produto (
    cd_produto INT,
    nm_produto VARCHAR(100),
    nm_marca_produto VARCHAR(100),
    dt_validade_produto DATE,
    qt_produto_estoque INT,
    qt_produto_utilizado INT,
    vl_produto_estoque DECIMAL(10 , 2 ),
    qt_ml_produto DECIMAL(10 , 2 ),
    qt_kg_produto DECIMAL(10 , 2 ),
    qt_li_produto DECIMAL(10 , 2 ),
    ds_produto TEXT,
    nm_fornecedor_produto VARCHAR(100),

    CONSTRAINT pk_produto PRIMARY KEY (cd_produto)
);
