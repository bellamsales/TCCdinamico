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


-- Excluir Produto
DELIMITER $$

CREATE PROCEDURE ExcluirProduto(
    IN p_cd_produto INT
)
BEGIN
    DELETE FROM Produto
    WHERE cd_produto = p_cd_produto;
END $$



-- Atualizar Produto
DELIMITER $$

CREATE PROCEDURE AtualizarProduto(
    IN p_cd_produto INT,
    IN p_nm_produto VARCHAR(100),
    IN p_nm_marca_produto VARCHAR(100),
    IN p_vl_produto_estoque DECIMAL(10,2),
    IN p_qt_produto_estoque INT,
    IN p_dt_validade_produto DATE  -- Adicione o parâmetro de data de validade
)
BEGIN
    UPDATE Produto
    SET nm_produto = p_nm_produto,
        nm_marca_produto = p_nm_marca_produto, -- Para marca do produto
        vl_produto_estoque = p_vl_produto_estoque,
        qt_produto_estoque = p_qt_produto_estoque,
        dt_validade_produto = p_dt_validade_produto -- Adicione a data de validade
    WHERE cd_produto = p_cd_produto;
END $$

DELIMITER ;


DELIMITER $$
CREATE PROCEDURE InserirProduto(
    IN p_cd_produto INT,
    IN p_nm_produto VARCHAR(100),
    IN p_vl_produto_estoque DECIMAL(10,2),
    IN p_nm_marca_produto VARCHAR(100),
    IN p_dt_validade_produto DATE,
    IN p_qt_produto_estoque INT
)
BEGIN
    INSERT INTO Produto(cd_produto, nm_produto, vl_produto_estoque, nm_marca_produto, dt_validade_produto, qt_produto_estoque)
    VALUES (p_cd_produto, p_nm_produto, p_vl_produto_estoque, p_nm_marca_produto, p_dt_validade_produto, p_qt_produto_estoque);
END$$


-- Consultar Produtos
/*DELIMITER $$

CREATE PROCEDURE ConsultarProdutos()
BEGIN
    SELECT cd_produto, nm_produto, ds_produto, vl_produto, qt_estoque
    FROM Produto;
END $$*/


-- Consultar produtos e verificar estoque
DELIMITER $$

DROP PROCEDURE IF EXISTS consultarProdutosEVerificarEstoque$$
CREATE PROCEDURE consultarProdutosEVerificarEstoque(
    IN p_min_estoque INT
)
BEGIN
    SELECT cd_produto, nm_produto, ds_produto, vl_produto, qt_estoque
    FROM Produto
    WHERE qt_estoque < p_min_estoque;
END $$


-- Adicionar um produto somente se a categoria existir
DELIMITER $$

DROP PROCEDURE IF EXISTS adicionarProdutoSeCategoriaExistir$$
CREATE PROCEDURE adicionarProdutoSeCategoriaExistir(
    IN p_nm_produto VARCHAR(100),
    IN p_ds_produto TEXT,
    IN p_vl_produto DECIMAL(10,2),
    IN p_qt_estoque INT,
    IN p_cd_categoria INT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se a categoria existe
    SELECT COUNT(*) INTO qtd FROM Categoria WHERE cd_categoria = p_cd_categoria;

    IF qtd > 0 THEN
        INSERT INTO Produto (nm_produto, ds_produto, vl_produto, qt_estoque, cd_categoria)
        VALUES (p_nm_produto, p_ds_produto, p_vl_produto, p_qt_estoque, p_cd_categoria);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoria não encontrada';
    END IF;
END $$


-- Buscar todos os fornecedores e suas médias de avaliação
DROP PROCEDURE IF EXISTS buscarFornecedores$$
CREATE PROCEDURE buscarFornecedores()
BEGIN
    SELECT cd_fornecedor, nm_fornecedor, buscarMediaAvaliacao(cd_fornecedor) AS media
    FROM Fornecedor;
END $$


-- Buscar a média de avaliações de um fornecedor
DROP FUNCTION IF EXISTS buscarMediaAvaliacao$$
CREATE FUNCTION buscarMediaAvaliacao(pCodigo INT) 
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE media DECIMAL(10,2) DEFAULT 0.0;

    SELECT COALESCE(AVG(vl_avaliacao), 0) INTO media 
    FROM Avaliacao 
    WHERE cd_fornecedor = pCodigo;

    RETURN media;
END $$


-- Consultar Produtos em Baixo Estoque
DELIMITER $$
DROP PROCEDURE IF EXISTS ConsultarProdutosBaixoEstoque$$
CREATE PROCEDURE ConsultarProdutosBaixoEstoque(
    IN p_nivel_estoque INT
)
BEGIN
    SELECT cd_produto, nm_produto, qt_estoque
    FROM Produto
    WHERE qt_estoque < p_nivel_estoque;
END $$


-- Consultar Estoque de um Produto
DELIMITER $$

CREATE PROCEDURE ConsultarEstoqueProduto(
    IN p_cd_produto INT
)
BEGIN
    SELECT qt_estoque
    FROM Produto
    WHERE cd_produto = p_cd_produto;
END $$


-- Consultar Produtos por Categoria
DELIMITER $$

CREATE PROCEDURE ConsultarProdutosPorCategoria(
    IN p_cd_categoria INT
)
BEGIN
    SELECT cd_produto, nm_produto, ds_produto, vl_produto, qt_estoque
    FROM Produto
    WHERE cd_categoria = p_cd_categoria;
END $$

DELIMITER $$
/*BuscarDadosProdutoPorCodigo*/
DROP PROCEDURE IF EXISTS buscarDadosProdutoPorCodigo$$
CREATE PROCEDURE buscarDadosProdutoPorCodigo(pCodigo int)
BEGIN
    SELECT cd_produto, nm_produto, nm_marca_produto, dt_validade_produto, 
           qt_produto_estoque, vl_produto_estoque
    FROM produto 
    WHERE cd_produto = pCodigo;
END$$

DELIMITER ;

