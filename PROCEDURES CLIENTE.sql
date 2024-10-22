USE bancotcc04;

-- Procedures Cliente --


-- Inserir um Cliente
DELIMITER $$
DROP PROCEDURE IF EXISTS InserirCliente$$
CREATE PROCEDURE InserirCliente(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_cliente VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_ds_historico_cliente TEXT
)
BEGIN
    INSERT INTO Cliente (nm_email_cliente, nm_cliente, nm_senha, nm_endereco, ds_historico_cliente)
    VALUES (p_nm_email_cliente, p_nm_cliente, p_nm_senha, p_nm_endereco, p_ds_historico_cliente);
END $$



-- Consultar Agendamentos de um Cliente
DELIMITER $$
DROP PROCEDURE IF EXISTS ConsultarAgendamentosCliente$$
CREATE PROCEDURE ConsultarAgendamentosCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    SELECT a.cd_agendamento, a.hr_agendamento, a.dt_agendamento, s.nm_servico
    FROM Agendamento a
    JOIN Itens_Agendamento ia ON a.cd_agendamento = ia.cd_agendamento
    JOIN Servico s ON ia.cd_servico = s.cd_servico
    WHERE a.nm_email_cliente = p_nm_email_cliente;
END $$


-- Cadastrar Cliente
DELIMITER $$
DROP PROCEDURE IF EXISTS CadastrarCliente$$
CREATE PROCEDURE CadastrarCliente(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_cliente VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_ds_historico_cliente TEXT
)
BEGIN
    INSERT INTO Cliente (nm_email_cliente, nm_cliente, nm_senha, nm_endereco, ds_historico_cliente)
    VALUES (p_nm_email_cliente, p_nm_cliente, p_nm_senha, p_nm_endereco, p_ds_historico_cliente);
END $$


-- Atualizar um cliente se ele existir
DROP PROCEDURE IF EXISTS atualizarClienteSeExistir$$
CREATE PROCEDURE atualizarClienteSeExistir(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_cliente VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_ds_historico_cliente TEXT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se o cliente existe
    SELECT COUNT(*) INTO qtd FROM Cliente WHERE nm_email_cliente = p_nm_email_cliente;

    IF qtd > 0 THEN
        UPDATE Cliente
        SET nm_cliente = p_nm_cliente, 
            nm_senha = p_nm_senha,
            nm_endereco = p_nm_endereco,
            ds_historico_cliente = p_ds_historico_cliente
        WHERE nm_email_cliente = p_nm_email_cliente;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente não encontrado';
    END IF;
END $$


-- Excluir Cliente
DELIMITER $$
DROP PROCEDURE IF EXISTS ExcluirCliente$$
CREATE PROCEDURE ExcluirCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    DELETE FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$


-- Excluir um cliente
DROP PROCEDURE IF EXISTS excluirCliente$$
CREATE PROCEDURE excluirCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    DELETE FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$


-- Consultar agendamentos de um cliente
DROP PROCEDURE IF EXISTS consultarAgendamentosCliente$$
CREATE PROCEDURE consultarAgendamentosCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    SELECT a.cd_agendamento, a.hr_agendamento, a.dt_agendamento, s.nm_servico
    FROM Agendamento a
    JOIN Itens_agendamento ia ON a.cd_agendamento = ia.cd_agendamento
    JOIN Servico s ON ia.cd_servico = s.cd_servico
    WHERE a.nm_email_cliente = p_nm_email_cliente;
END $$


-- Atualizar Cliente
DELIMITER $$
DROP PROCEDURE IF EXISTS AtualizarCliente$$
CREATE PROCEDURE AtualizarCliente(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_cliente VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_ds_historico_cliente TEXT
)
BEGIN
    UPDATE Cliente
    SET nm_cliente = p_nm_cliente, 
        nm_senha = p_nm_senha,
        nm_endereco = p_nm_endereco,
        ds_historico_cliente = p_ds_historico_cliente
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$


-- Consultar Clientes
DELIMITER $$
DROP PROCEDURE IF EXISTS ConsultarClientes$$
CREATE PROCEDURE ConsultarClientes()
BEGIN
    SELECT nm_email_cliente, nm_cliente, nm_endereco
    FROM Cliente;
END $$


-- Adicionar um novo cliente
DROP PROCEDURE IF EXISTS adicionarCliente$$
CREATE PROCEDURE adicionarCliente(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_cliente VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_ds_cliente TEXT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se o cliente já existe
    SELECT COUNT(*) INTO qtd FROM Cliente WHERE nm_email_cliente = p_nm_email_cliente;

    IF qtd = 0 THEN
        INSERT INTO Cliente (nm_email_cliente, nm_cliente, nm_senha, nm_endereco, ds_cliente)
        VALUES (p_nm_email_cliente, p_nm_cliente, p_nm_senha, p_nm_endereco, p_ds_cliente);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente já cadastrado';
    END IF;
END $$


-- Atualizar cliente se ele Existir
DELIMITER $$

DROP PROCEDURE IF EXISTS atualizarClienteSeExistir$$
CREATE PROCEDURE atualizarClienteSeExistir(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_cliente VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_ds_historico_cliente TEXT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se o cliente existe
    SELECT COUNT(*) INTO qtd FROM Cliente WHERE nm_email_cliente = p_nm_email_cliente;

    IF qtd > 0 THEN
        UPDATE Cliente
        SET nm_cliente = p_nm_cliente, 
            nm_senha = p_nm_senha,
            nm_endereco = p_nm_endereco,
            ds_historico_cliente = p_ds_historico_cliente
        WHERE nm_email_cliente = p_nm_email_cliente;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente não encontrado';
    END IF;
END $$


-- Excluir um cliente
DROP PROCEDURE IF EXISTS excluirCliente$$
CREATE PROCEDURE excluirCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    DELETE FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$


-- Adicionar um novo cliente
DROP PROCEDURE IF EXISTS adicionarCliente$$
CREATE PROCEDURE adicionarCliente(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_cliente VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_ds_cliente TEXT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se o cliente já existe
    SELECT COUNT(*) INTO qtd FROM Cliente WHERE nm_email_cliente = p_nm_email_cliente;

    IF qtd = 0 THEN
        INSERT INTO Cliente (nm_email_cliente, nm_cliente, nm_senha, nm_endereco, ds_cliente)
        VALUES (p_nm_email_cliente, p_nm_cliente, p_nm_senha, p_nm_endereco, p_ds_cliente);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente já cadastrado';
    END IF;
END $$


-- Consultar Clientes por Nome 
DELIMITER $$
DROP PROCEDURE IF EXISTS  ConsultarClientesPorNome$$
CREATE PROCEDURE ConsultarClientesPorNome(
    IN p_nm_cliente VARCHAR(200)
)
BEGIN
    SELECT nm_email_cliente, nm_cliente, nm_endereco
    FROM Cliente
    WHERE nm_cliente LIKE CONCAT('%', p_nm_cliente, '%');
END $$


-- Consultar Historico Cliente
DELIMITER $$
DROP PROCEDURE IF EXISTS  ConsultarHistoricoCliente$$
CREATE PROCEDURE ConsultarHistoricoCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    SELECT ds_historico_cliente
    FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$


-- Adicionar Histórico do Cliente
DELIMITER $$
DROP PROCEDURE IF EXISTS AdicionarHistoricoCliente$$
CREATE PROCEDURE AdicionarHistoricoCliente(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_ds_historico_cliente TEXT
)
BEGIN
    UPDATE Cliente
    SET ds_historico_cliente = CONCAT(ds_historico_cliente, '\n', p_ds_historico_cliente)
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$