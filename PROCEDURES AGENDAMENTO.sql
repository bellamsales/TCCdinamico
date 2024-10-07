USE bancotcc04;

DELIMITER $$
-- AGENDAMENTO DE SERVIÇOS
-- AUTO_INCREMENT ADCIONADO PARA MELHORAR INSTERTs
DROP PROCEDURE IF EXISTS AgendarServico$$
CREATE PROCEDURE AgendarServico(in pCliente varchar(50), in pServico int, in pHora time, in pData date, pFuncionario varchar(50))
BEGIN
	DECLARE vFuncionario varchar(50);
    select nm_email_funcionario into vFuncionario from especialidade_funcionario where nm_email_funcionario = pFuncionario and cd_servico = pServico;
    IF (vFuncionario IS NULL)
    THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Funcionario não presta este serviço.';
	ELSE
		insert into agendamento values (default, pServico, pHora,pData, pCliente, pFuncionario);
	END IF;
END $$

-- BUSCA DOS AGENDAMENTOS PROXIMOS DE DETERMINADO CLIENTE
DROP PROCEDURE IF EXISTS ConsultarAgendamentosProximosCliente$$
CREATE PROCEDURE ConsultarAgendamentosProximosCliente(in pCliente varchar(50))
BEGIN
	select 
	ag.cd_agendamento, ag.cd_servico, ag.dt_agendamento, ag.hr_agendamento, ag.nm_email_funcionario,f.nm_funcionario,f.nm_cargo, s.nm_servico
from agendamento ag 
	join servico s on (ag.cd_servico = s.cd_servico) 
join funcionario f on (ag.nm_email_funcionario = f.nm_email_funcionario)
where nm_email_cliente = pCliente and dt_agendamento > curdate() order by dt_agendamento;
END $$
DROP PROCEDURE IF EXISTS ConsultarCategorias$$
CREATE PROCEDURE ConsultarCategorias()
BEGIN
    SELECT cd_categoria, nm_categoria
    FROM Categoria;
END $$

DROP PROCEDURE IF EXISTS ConsultarServicosPorCategoria$$
CREATE PROCEDURE ConsultarServicosPorCategoria(
    IN p_cd_categoria INT
)
BEGIN
    SELECT cd_servico, nm_servico, cd_categoria
    FROM Servico
    WHERE cd_categoria = p_cd_categoria;
END $$
DROP PROCEDURE IF EXISTS ConsultarFuncionariosPorServico$$
CREATE PROCEDURE ConsultarFuncionariosPorServico(
    IN p_cd_servico INT
)
BEGIN
    select f.nm_funcionario, f.nm_email_funcionario, ef.cd_servico 
from funcionario f 
join especialidade_funcionario ef on (f.nm_email_funcionario = ef.nm_email_funcionario)
where cd_servico = p_cd_servico;
END $$

DROP PROCEDURE IF EXISTS ConsultarDataDisponibilidadeFuncionario$$
CREATE PROCEDURE ConsultarDataDisponibilidadeFuncionario(p_funcionario varchar(50))
BEGIN
	select dt_inicio_disponibilidade
    from disponibilidade d
join disponibilidade_funcionario df on (d.cd_disponibilidade = df.cd_disponibilidade_funcionario)
    Where dt_inicio_disponibilidade >= curdate() and df.nm_email_funcionario = p_funcionario group by d.dt_inicio_disponibilidade;
END$$

DROP PROCEDURE IF EXISTS ConsultarHoraDisponibilidadeFuncionario$$
CREATE PROCEDURE ConsultarHoraDisponibilidadeFuncionario(p_funcionario varchar(50), p_data date, p_periodo varchar(50))
BEGIN
	select hr_inicio_disponibilidade, hr_fim_disponibilidade
    from disponibilidade d
join disponibilidade_funcionario df on (d.cd_disponibilidade = df.cd_disponibilidade_funcionario)
    Where dt_inicio_disponibilidade >= curdate() and df.nm_email_funcionario = p_funcionario and dt_inicio_disponibilidade = p_data and nm_periodo_disponibilidade=p_periodo;
END$$

DROP PROCEDURE IF EXISTS ConsultarFuncionarios$$
CREATE PROCEDURE ConsultarFuncionarios()
BEGIN
    select f.nm_funcionario, f.nm_email_funcionario
from funcionario f;
END $$
DROP PROCEDURE IF EXISTS ConsultarAgendamentosPorFuncionarioData$$
CREATE PROCEDURE ConsultarAgendamentosPorFuncionarioData(
    IN p_funcionario_email VARCHAR(50),
    IN p_data_agendamento DATE
)
BEGIN
    SELECT 
        a.hr_agendamento, 
        s.nm_servico, 
        c.nm_cliente
    FROM 
        agendamento a
    JOIN 
        servico s ON s.cd_servico = a.cd_servico
    JOIN 
        cliente c ON c.nm_email_cliente = a.nm_email_cliente
    WHERE 
        a.nm_email_funcionario = p_funcionario_email
        AND a.dt_agendamento = p_data_agendamento;
END$$

DROP PROCEDURE IF EXISTS LoginCliente$$
CREATE PROCEDURE LoginCliente (
    IN p_email_cliente VARCHAR(50),
    IN p_senha_cliente VARCHAR(8)
)
BEGIN
    DECLARE v_count INT;

    -- Verifica se o email e senha estão corretos
    SELECT COUNT(*)
    INTO v_count
    FROM Cliente
    WHERE nm_email_cliente = p_email_cliente
      AND nm_senha = p_senha_cliente;

    -- Se o resultado for maior que 0, o login está correto
    IF v_count > 0 THEN
        SELECT true AS mensagem;
    ELSE
        SELECT false AS mensagem;
    END IF;
END$$

DROP PROCEDURE IF EXISTS LoginCliente$$
CREATE PROCEDURE LoginCliente(
    IN p_email_cliente VARCHAR(50),
    IN p_senha_cliente VARCHAR(8)
)
BEGIN
    DECLARE v_mensagem BOOLEAN DEFAULT FALSE;

    -- Verifica se existe um cliente com o e-mail e senha fornecidos
    IF EXISTS (
        SELECT 1 FROM cliente 
        WHERE nm_email_cliente = p_email_cliente 
        AND nm_senha = p_senha_cliente
    ) THEN
        SET v_mensagem = TRUE;
    END IF;

    -- Retorna o resultado da verificação
    SELECT v_mensagem AS mensagem;
END $$

DELIMITER $$

DROP PROCEDURE IF EXISTS LoginFuncionario$$
CREATE PROCEDURE LoginFuncionario(
    IN p_email_funcionario VARCHAR(255),
    IN p_senha_funcionario VARCHAR(255)
)
BEGIN
    DECLARE v_mensagem BOOLEAN DEFAULT FALSE;

    -- Verifica se existe um funcionário com o e-mail e senha fornecidos
    IF EXISTS (
        SELECT 1 FROM funcionario 
        WHERE nm_email_funcionario = p_email_funcionario 
        AND nm_senha = p_senha_funcionario
    ) THEN
        SET v_mensagem = TRUE;
    END IF;

    -- Retorna o resultado da verificação
    SELECT v_mensagem AS mensagem;
END$$


DELIMITER $$

CREATE PROCEDURE VerificarCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    
Select * from cliente where nm_email_cliente = p_nm_email_cliente;

END $$


CREATE PROCEDURE ConsultarFuncionariosPorCategoria(IN p_cd_categoria INT)
BEGIN
    SELECT f.nm_email_funcionario, f.nm_funcionario 
    FROM Funcionario f
    JOIN Especialidade_funcionario_categoria e ON f.nm_email_funcionario = e.nm_email_funcionario
    WHERE e.cd_categoria = p_cd_categoria;
END$$

CREATE PROCEDURE ConsultarCategoriaPorServico(IN p_cd_servico INT)
BEGIN
    SELECT c.cd_categoria, c.nm_categoria 
    FROM Categoria c
    JOIN Servico s ON c.cd_categoria = s.cd_categoria 
    WHERE s.cd_servico = p_cd_servico;
END$$

DELIMITER ;
call ConsultarFuncionarios();
call AgendarServico("ana.oliveira@email.com", 0, current_time(), curdate(), "anaclara@gmail.com");


call ConsultarHoraDisponibilidadeFuncionario('anaclara@gmail.com', '2024-01-02', 'Manhã');
CALL ConsultarAgendamentosPorFuncionarioData('anaclara@gmail.com', '2024-01-02');


select a.hr_agendamento, s.nm_servico, c.nm_cliente from agendamento a 
join servico s on s.cd_servico = a.cd_servico 
join cliente c on c.nm_email_cliente = a.nm_email_cliente
where nm_email_funcionario = 'anaclara@gmail.com' and dt_agendamento = '2024-01-02';
CALL ConsultarDisponibilidadeFuncionarioPorData('anaclara@gmail.com', '2024-01-02');
