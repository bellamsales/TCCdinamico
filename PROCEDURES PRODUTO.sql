USE bancotcc04;

delimiter $$
DROP PROCEDURE IF EXISTS ConsultarProdutos$$
CREATE PROCEDURE ConsultarProdutos()
BEGIN
    SELECT cd_produto, nm_produto, ds_produto_estoque, vl_produto_estoque,   qt_produto_estoque
    FROM Produto;
END $$

delimiter ;