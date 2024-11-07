USE bancotcc04;

-- Procedures Funcionário --


DELIMITER $$

DROP PROCEDURE IF EXISTS AtualizarDisponibilidadeFuncionario$$
CREATE PROCEDURE AtualizarDisponibilidadeFuncionario(
    IN p_cd_disponibilidade_funcionario INT,
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_cd_disponibilidade INT
)
BEGIN
    UPDATE Disponibilidade_funcionario
    SET cd_disponibilidade = p_cd_disponibilidade
    WHERE cd_disponibilidade_funcionario = p_cd_disponibilidade_funcionario
    AND nm_email_funcionario = p_nm_email_funcionario;
END $$

DELIMITER $$

DROP PROCEDURE IF EXISTS excluirFuncionario$$
CREATE PROCEDURE excluirFuncionario(
    IN p_nm_email_funcionario VARCHAR(50)
)
BEGIN

    DELETE FROM especialidade_funcionario WHERE nm_email_funcionario = p_nm_email_funcionario;

 
    DELETE FROM disponibilidade_funcionario WHERE nm_email_funcionario = p_nm_email_funcionario;

    
    DELETE FROM agendamento WHERE nm_email_funcionario = p_nm_email_funcionario;

  
    DELETE FROM Funcionario WHERE nm_email_funcionario = p_nm_email_funcionario;
END $$

DELIMITER $$

DROP PROCEDURE IF EXISTS FuncionarioTemAgendamentos$$
CREATE PROCEDURE FuncionarioTemAgendamentos(IN p_email VARCHAR(255), OUT p_count INT)
BEGIN
   
    SELECT COUNT(*) INTO p_count 
    FROM Agendamento 
    WHERE nm_email_funcionario = p_email;
END $$

DELIMITER $$

DROP PROCEDURE IF EXISTS InserirFuncionario$$

CREATE PROCEDURE InserirFuncionario(
    IN p_nm_funcionario VARCHAR(200),
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_nm_telefone VARCHAR(15),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_endereco VARCHAR(300),
    IN p_nm_cargo VARCHAR(100),
    IN p_nm_CPF VARCHAR(11)  
)
BEGIN
  
    DECLARE funcionario_existe INT;

    SELECT COUNT(*)
    INTO funcionario_existe
    FROM Funcionario
    WHERE nm_email_funcionario = p_nm_email_funcionario OR nm_CPF = p_nm_CPF;  

    IF funcionario_existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Um funcionário já existe com este e-mail ou CPF.';
    ELSE
        INSERT INTO Funcionario (nm_funcionario, nm_email_funcionario, nm_telefone, nm_senha, nm_endereco, nm_cargo, nm_CPF)
        VALUES (p_nm_funcionario, p_nm_email_funcionario, p_nm_telefone, p_nm_senha, p_nm_endereco, p_nm_cargo, p_nm_CPF);
    END IF;
END $$


DELIMITER $$

DROP PROCEDURE IF EXISTS CadastrarFuncionario$$
CREATE PROCEDURE CadastrarFuncionario(
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_nm_funcionario VARCHAR(200),
    IN p_nm_senha VARCHAR(45),
    IN p_nm_telefone VARCHAR(15),
    IN p_nm_endereco VARCHAR(300),
    IN p_nm_cargo VARCHAR(100)
)
BEGIN
    INSERT INTO Funcionario (nm_email_funcionario, nm_funcionario, nm_senha, nm_telefone, nm_endereco, nm_cargo)
    VALUES (p_nm_email_funcionario, p_nm_funcionario, p_nm_senha, p_nm_telefone, p_nm_endereco, p_nm_cargo);
END $$

DELIMITER $$

DROP PROCEDURE IF EXISTS ConsultarFuncionarioPorEmail$$

CREATE PROCEDURE ConsultarFuncionarioPorEmail(
    IN p_nm_email_funcionario VARCHAR(255)
)
BEGIN
    SELECT 
        nm_email_funcionario, 
        nm_funcionario, 
        nm_telefone, 
        nm_endereco, 
        nm_cargo,
        nm_cpf 
    FROM 
        funcionario
    WHERE 
        nm_email_funcionario = p_nm_email_funcionario;
END$$




DELIMITER $$

DROP PROCEDURE IF EXISTS  ConsultarDisponibilidadeFuncionario$$
CREATE PROCEDURE ConsultarDisponibilidadeFuncionario(
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_nm_dia_semana VARCHAR(30)
)
BEGIN
    SELECT d.hr_inicio, d.hr_fim
    FROM Disponibilidade AS d
    INNER JOIN Disponibilidade_funcionario AS df ON d.cd_disponibilidade = df.cd_disponibilidade
    WHERE df.nm_email_funcionario = p_nm_email_funcionario
    AND d.nm_dia_semana = p_nm_dia_semana;
END $$


DELIMITER $$
DROP PROCEDURE IF EXISTS ConsultarFuncionarios$$
CREATE PROCEDURE ConsultarFuncionarios()
BEGIN
    SELECT 
        f.nm_email_funcionario,
        f.nm_funcionario,
        f.nm_telefone,
        f.nm_endereco,
        f.nm_cargo,
        f.nm_cpf,
        f.ativo  
    FROM 
        Funcionario f
    LEFT JOIN 
        Especialidade_funcionario e ON f.nm_email_funcionario = e.nm_email_funcionario
    LEFT JOIN 
        Servico s ON e.cd_servico = s.cd_servico 
    GROUP BY 
        f.nm_email_funcionario, 
        f.nm_funcionario, 
        f.nm_telefone, 
        f.nm_endereco, 
        f.nm_cargo, 
        f.nm_cpf,
        f.ativo  
    ORDER BY 
        f.nm_funcionario;  
END $$
 


DELIMITER $$

DROP PROCEDURE IF EXISTS FuncionarioInativo$$
CREATE PROCEDURE FuncionarioInativo(IN p_nm_email_funcionario VARCHAR(255))
BEGIN
    
    DECLARE funcionario_existe INT;

    SELECT COUNT(*)
    INTO funcionario_existe
    FROM Funcionario
    WHERE nm_email_funcionario = p_nm_email_funcionario;

    IF funcionario_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Funcionário não encontrado.';
    ELSE
        UPDATE Funcionario
        SET ativo = false
        WHERE nm_email_funcionario = p_nm_email_funcionario;  
    END IF;
END $$



DELIMITER $$
DROP PROCEDURE IF EXISTS AtualizarFuncionario$$
CREATE PROCEDURE AtualizarFuncionario(
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_nm_novo_email VARCHAR(50),
    IN p_nm_funcionario VARCHAR(200),
    IN p_nm_senha VARCHAR(8),
    IN p_nm_telefone VARCHAR(15),
    IN p_nm_endereco VARCHAR(300),
    IN p_nm_cargo VARCHAR(100)
   
)
BEGIN
 
    UPDATE Funcionario
    SET nm_email_funcionario = p_nm_novo_email,
        nm_funcionario = p_nm_funcionario,
        nm_senha = p_nm_senha,
        nm_telefone = p_nm_telefone,
        nm_endereco = p_nm_endereco,
        nm_cargo = p_nm_cargo
        
    WHERE nm_email_funcionario = p_nm_email_funcionario;

  
    UPDATE Especialidade_funcionario
    SET nm_email_funcionario = p_nm_novo_email
    WHERE nm_email_funcionario = p_nm_email_funcionario;


    UPDATE Agendamento
    SET nm_email_funcionario = p_nm_novo_email
    WHERE nm_email_funcionario = p_nm_email_funcionario;

  
    UPDATE Disponibilidade_funcionario
    SET nm_email_funcionario = p_nm_novo_email
    WHERE nm_email_funcionario = p_nm_email_funcionario;
END$$


DROP PROCEDURE IF EXISTS ObterFuncionarioPorCPF$$
CREATE PROCEDURE ObterFuncionarioPorCPF
    @cpf VARCHAR(11) 
AS
BEGIN
    SELECT nm_cpf
    FROM Funcionario
    WHERE nm_cpf = @cpf;
END


DELIMITER $$

DROP PROCEDURE IF EXISTS atualizarDisponibilidadeFuncionarioSeLivre$$
CREATE PROCEDURE atualizarDisponibilidadeFuncionarioSeLivre(
    IN p_cd_disponibilidade_funcionario INT,
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_cd_disponibilidade INT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;


    SELECT COUNT(*) INTO qtd 
    FROM Disponibilidade_funcionario 
    WHERE nm_email_funcionario = p_nm_email_funcionario 
    AND cd_disponibilidade = p_cd_disponibilidade;

    IF qtd = 0 THEN
        UPDATE Disponibilidade_funcionario
        SET cd_disponibilidade = p_cd_disponibilidade
        WHERE cd_disponibilidade_funcionario = p_cd_disponibilidade_funcionario
        AND nm_email_funcionario = p_nm_email_funcionario;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Funcionário já está ocupado neste horário';
    END IF;
END $$



DELIMITER $$
DROP PROCEDURE IF EXISTS ConsultarAgendamentosFuncionario$$
CREATE PROCEDURE ConsultarAgendamentosFuncionario(
    IN p_nm_email_funcionario VARCHAR(50)
)
BEGIN
    SELECT a.cd_agendamento, a.hr_agendamento, a.dt_agendamento, c.nm_cliente, s.nm_servico
    FROM Agendamento a
    JOIN Cliente c ON a.nm_email_cliente = c.nm_email_cliente
    JOIN Servico s ON a.cd_servico = s.cd_servico
    WHERE a.nm_email_funcionario = p_nm_email_funcionario;
END $$



DELIMITER $$
DROP PROCEDURE IF EXISTS ConsultarTodosFuncionarios$$
CREATE PROCEDURE ConsultarTodosFuncionarios()
BEGIN
    SELECT nm_email_funcionario, nm_funcionario, nm_endereco, nm_cargo
    FROM Funcionario;
END $$



