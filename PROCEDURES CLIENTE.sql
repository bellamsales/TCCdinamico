USE bancotcc04;

-- Procedures Cliente --



DELIMITER $$

DROP PROCEDURE IF EXISTS InserirCliente$$
CREATE PROCEDURE InserirCliente(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_cliente VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_ds_cliente TEXT,
    IN p_nm_cpf VARCHAR(11)  
)
BEGIN

    DECLARE cliente_existe INT;

    SELECT COUNT(*)
    INTO cliente_existe
    FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente OR nm_cpf = p_nm_cpf;  

    IF cliente_existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Um cliente já existe com este e-mail ou CPF.';
    ELSE
        INSERT INTO Cliente (nm_email_cliente, nm_cliente, nm_senha, nm_endereco, ds_cliente, nm_cpf)  
        VALUES (p_nm_email_cliente, p_nm_cliente, p_nm_senha, p_nm_endereco, p_ds_cliente, p_nm_cpf);
    END IF;
END $$




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


DELIMITER $$
DROP PROCEDURE IF EXISTS ExcluirCliente$$
CREATE PROCEDURE ExcluirCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    DELETE FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$



DROP PROCEDURE IF EXISTS excluirCliente$$
CREATE PROCEDURE excluirCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    DELETE FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$



DELIMITER $$
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



DELIMITER $$
DROP PROCEDURE IF EXISTS AtualizarCliente$$
CREATE PROCEDURE AtualizarCliente(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_novo_email VARCHAR(50),
    IN p_nm_cliente VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_ds_cliente TEXT
)
BEGIN
    DECLARE v_email_existente INT;

  
    SELECT COUNT(*) INTO v_email_existente 
    FROM Cliente 
    WHERE nm_email_cliente = p_nm_novo_email AND nm_email_cliente != p_nm_email_cliente;

    IF v_email_existente > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O novo email já está em uso.';
    ELSE
 
        UPDATE Cliente
        SET nm_email_cliente = p_nm_novo_email,
            nm_cliente = p_nm_cliente, 
            nm_senha = p_nm_senha,
            nm_endereco = p_nm_endereco,
            ds_cliente = p_ds_cliente
        WHERE nm_email_cliente = p_nm_email_cliente;
    END IF;
END $$





DELIMITER $$
DROP PROCEDURE IF EXISTS AtualizarEmailEmDependentes$$
CREATE PROCEDURE AtualizarEmailEmDependentes(IN p_email_atual VARCHAR(50), IN p_email_novo VARCHAR(50))
BEGIN
   
    UPDATE Agendamento
    SET nm_email_cliente = p_email_novo
    WHERE nm_email_cliente = p_email_atual;

END$$



DELIMITER $$

DROP PROCEDURE IF EXISTS ConsultarClientes$$

CREATE PROCEDURE ConsultarClientes()
BEGIN
    SELECT cd_cliente, nm_email_cliente, nm_cliente, nm_endereco, ds_cliente, ativo, nm_cpf
    FROM Cliente;
END $$

DROP PROCEDURE IF EXISTS ConsultarClientesporemail$$

CREATE PROCEDURE ConsultarClientesporemail(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    SELECT cd_cliente, nm_email_cliente, nm_cliente, nm_endereco, ds_cliente, ativo, nm_cpf 
    FROM Cliente 
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$ 


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

DELIMITER $$

DROP PROCEDURE IF EXISTS ClienteInativo$$
CREATE PROCEDURE ClienteInativo(IN p_nm_email_cliente VARCHAR(255))
BEGIN
   
    DECLARE cliente_existe INT;

    SELECT COUNT(*)
    INTO cliente_existe
    FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente;

    IF cliente_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Cliente não encontrado.';
    ELSE
        UPDATE Cliente
        SET ativo = false
        WHERE nm_email_cliente = p_nm_email_cliente;  
    END IF;
END $$


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

   
    SELECT COUNT(*) INTO qtd FROM Cliente WHERE nm_email_cliente = p_nm_email_cliente;

    IF qtd = 0 THEN
        INSERT INTO Cliente (nm_email_cliente, nm_cliente, nm_senha, nm_endereco, ds_cliente)
        VALUES (p_nm_email_cliente, p_nm_cliente, p_nm_senha, p_nm_endereco, p_ds_cliente);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente já cadastrado';
    END IF;
END $$



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

DROP PROCEDURE IF EXISTS ClienteInativo$$
CREATE PROCEDURE ClienteInativo(IN p_nm_email_cliente VARCHAR(255))
BEGIN
    
    DECLARE cliente_existe INT;

    SELECT COUNT(*)
    INTO cliente_existe
    FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente;

    IF cliente_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Cliente não encontrado.';
    ELSE
        UPDATE Cliente
        SET ativo = false
        WHERE nm_email_cliente = p_nm_email_cliente;  
    END IF;
END $$



DELIMITER $$

DROP PROCEDURE IF EXISTS excluirCliente$$
CREATE PROCEDURE excluirCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    DECLARE cliente_existe INT;

  
    SELECT COUNT(*)
    INTO cliente_existe
    FROM Cliente
    WHERE nm_email_cliente = p_nm_email_cliente;

    IF cliente_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Cliente não encontrado.';
    ELSE
        DELETE FROM Cliente
        WHERE nm_email_cliente = p_nm_email_cliente;
    END IF;
END $$



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

    
    SELECT COUNT(*) INTO qtd FROM Cliente WHERE nm_email_cliente = p_nm_email_cliente;

    IF qtd = 0 THEN
        INSERT INTO Cliente (nm_email_cliente, nm_cliente, nm_senha, nm_endereco, ds_cliente)
        VALUES (p_nm_email_cliente, p_nm_cliente, p_nm_senha, p_nm_endereco, p_ds_cliente);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente já cadastrado';
    END IF;
END $$



DELIMITER $$

DROP PROCEDURE IF EXISTS ConsultarClientesPorNome$$
CREATE PROCEDURE ConsultarClientesPorNome(
    IN p_nm_cliente VARCHAR(200)
)
BEGIN
    SELECT cd_cliente, nm_email_cliente, nm_cliente, nm_endereco
    FROM Cliente
    WHERE nm_cliente LIKE CONCAT('%', p_nm_cliente, '%');
END $$



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

DELIMITER $$


DROP PROCEDURE IF EXISTS AtualizarEmailAgendamentos$$
CREATE PROCEDURE AtualizarEmailAgendamentos(
    IN p_email_atual VARCHAR(50),
    IN p_email_novo VARCHAR(50)
)
BEGIN

    UPDATE Agendamento
    SET nm_email_cliente = p_email_novo
    WHERE nm_email_cliente = p_email_atual;
END$$


DROP PROCEDURE IF EXISTS AtualizarEmailFeedbacks$$
CREATE PROCEDURE AtualizarEmailFeedbacks(
    IN p_email_atual VARCHAR(50),
    IN p_email_novo VARCHAR(50)
)
BEGIN

    UPDATE Feedback
    SET nm_email_cliente = p_email_novo
    WHERE nm_email_cliente = p_email_atual;
END$$

DELIMITER $$

