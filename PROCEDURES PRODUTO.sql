USE bancotcc04;

DELIMITER $$
DROP PROCEDURE IF EXISTS ConsultarProdutos$$
CREATE PROCEDURE ConsultarProdutos()
BEGIN
    SELECT cd_produto, nm_produto, nm_marca_produto, dt_validade_produto, 
           qt_produto_estoque, qt_produto_utilizado, vl_produto_estoque,
           nm_fornecedor_produto
    FROM Produto;
END $$

DELIMITER ;