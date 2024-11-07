USE bancotcc04;

DELIMITER $$

DROP PROCEDURE IF EXISTS AgendarServico$$
CREATE PROCEDURE AgendarServico(
    IN pCliente VARCHAR(50), 
    IN pServico INT, 
    IN pHora TIME, 
    IN pData DATE, 
    IN pFuncionario VARCHAR(50), 
    IN pDuracao INT 
)
BEGIN
    DECLARE vFuncionario VARCHAR(50);
    DECLARE vHorarioFim TIME;
    DECLARE vHorarioLimiteAlmoco TIME DEFAULT '12:00:00';
    DECLARE vHorarioLimiteFim TIME DEFAULT '20:00:00';
    DECLARE vIdAgendamento INT;
    DECLARE vUltimoHorarioDisponivel TIME;

    -- Calculate end time based on duration
    SET vHorarioFim = ADDTIME(pHora, SEC_TO_TIME(pDuracao * 60));

    -- Determine the last available time for the selected start time
    IF pHora >= '08:00:00' AND pHora < '12:00:00' THEN
        IF pDuracao = 30 THEN
            SET vUltimoHorarioDisponivel = '11:30:00';
        ELSEIF pDuracao = 60 THEN
            SET vUltimoHorarioDisponivel = '11:00:00';
        ELSEIF pDuracao = 120 THEN
            SET vUltimoHorarioDisponivel = '10:00:00';
        END IF;
    ELSEIF pHora >= '13:00:00' AND pHora < '17:30:00' THEN
        SET vUltimoHorarioDisponivel = '17:30:00';
    ELSEIF pHora >= '18:00:00' AND pHora < '20:00:00' THEN
        SET vUltimoHorarioDisponivel = '20:00:00';
    END IF;

  
    SELECT nm_email_funcionario INTO vFuncionario 
    FROM especialidade_funcionario 
    WHERE nm_email_funcionario = pFuncionario 
      AND cd_servico = pServico;

    IF vFuncionario IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Funcionario não presta este serviço.';
    
    ELSEIF vHorarioFim > vHorarioLimiteAlmoco AND pHora < vHorarioLimiteAlmoco THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O serviço ultrapassa o horário de almoço.';
    
    ELSEIF vHorarioFim > vHorarioLimiteFim THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O serviço ultrapassa o horário de funcionamento.';
    
    ELSEIF pHora > vUltimoHorarioDisponivel THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Horário selecionado não está disponível.';
    
    ELSEIF EXISTS (
        SELECT 1 FROM agendamento 
        WHERE nm_email_funcionario = pFuncionario 
        AND dt_agendamento = pData 
        AND (
            (pHora >= horario_inicio AND pHora < horario_fim) OR 
            (vHorarioFim > horario_inicio AND vHorarioFim <= horario_fim) OR 
            (pHora < horario_inicio AND vHorarioFim > horario_fim)
        )
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O horário já está reservado.';
    
    ELSE
      
        INSERT INTO agendamento (id_agendamento, cd_servico, horario_inicio, dt_agendamento, nm_cliente, nm_email_funcionario) 
        VALUES (DEFAULT, pServico, pHora, pData, pCliente, pFuncionario);

       
        UPDATE agendamento 
        SET horario_fim = vHorarioFim
        WHERE nm_email_funcionario = pFuncionario 
        AND dt_agendamento = pData 
        AND horario_inicio = pHora;

       
        SET vIdAgendamento = LAST_INSERT_ID();
        SELECT vIdAgendamento AS IdAgendamento;
    END IF;
END $$

DELIMITER $$
DROP PROCEDURE IF EXISTS ConsultarHorariosOcupados$$
CREATE PROCEDURE ConsultarHorariosOcupados(
    IN p_funcionario VARCHAR(255),
    IN p_data DATE
)
BEGIN
    SELECT TIME_FORMAT(hr_agendamento, '%H:%i') AS horario_ocupado
    FROM Agendamento
    WHERE nm_email_funcionario = p_funcionario
    AND dt_agendamento = p_data;
END $$

DELIMITER $$
DROP PROCEDURE IF EXISTS ObterDuracaoServico$$
CREATE PROCEDURE ObterDuracaoServico(
    IN ServicoId INT,
    OUT Duracao TIME
)
BEGIN
    DECLARE DuracaoTemp TIME;

  
    SELECT qt_tempo_servico INTO DuracaoTemp
    FROM Servico
    WHERE cd_servico = ServicoId;

    IF DuracaoTemp IS NULL THEN
        
        SET Duracao = '00:00:00'; 
    ELSE
        SET Duracao = DuracaoTemp;
    END IF;
END $$


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
END$$

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
join especialidade_funcionario ef on (ef.nm_email_funcionario = df.nm_email_funcionario)
join servico s on (ef.cd_servico = s.cd_servico)
    Where dt_inicio_disponibilidade >= curdate() and df.nm_email_funcionario = p_funcionario and dt_inicio_disponibilidade = p_data and nm_periodo_disponibilidade=p_periodo;
END$$


DROP PROCEDURE IF EXISTS ConsultarDisponibilidadeFuncionario$$
CREATE PROCEDURE ConsultarDisponibilidadeFuncionario(p_funcionario varchar(50), p_mes INT)
BEGIN
    SELECT 
        d.dt_inicio_disponibilidade AS Data,
        d.nm_periodo_disponibilidade AS Periodo
    FROM 
        Disponibilidade d
    JOIN 
        Disponibilidade_funcionario df ON d.cd_disponibilidade = df.cd_disponibilidade_funcionario 
    WHERE 
        df.nm_email_funcionario = p_funcionario
        AND MONTH(d.dt_inicio_disponibilidade) = p_mes;
END$$
 
DROP PROCEDURE IF EXISTS ListarHorariosPorPeriodo$$
CREATE PROCEDURE ListarHorariosPorPeriodo(IN funcionario_email VARCHAR(255))
BEGIN
    SELECT 
        d.dt_inicio_disponibilidade AS Data_Inicio,
        d.hr_inicio_disponibilidade AS Hora_Inicio,
        d.dt_fim_disponibilidade AS Data_Fim,
        d.hr_fim_disponibilidade AS Hora_Fim,
        d.nm_periodo_disponibilidade AS Periodo,
        df.nm_email_funcionario AS Email_Funcionario
    FROM 
        Disponibilidade d
    JOIN 
        Disponibilidade_funcionario df ON d.cd_disponibilidade = df.cd_disponibilidade_funcionario
    WHERE 
        df.nm_email_funcionario = funcionario_email -- Filtra pelo e-mail do funcionário
    ORDER BY 
        d.dt_inicio_disponibilidade, d.hr_inicio_disponibilidade;
END $$

DROP PROCEDURE IF EXISTS sp_ObterHorariosDisponiveis$$
CREATE PROCEDURE sp_ObterHorariosDisponiveis(
    IN data DATE,
    IN periodo INT,
    IN funcionarioEmail VARCHAR(255)
)
BEGIN
    SELECT 
        h.horario AS Horario
    FROM 
        Horarios h
    JOIN 
        Disponibilidade d ON h.id_disponibilidade = d.id_disponibilidade
    JOIN 
        Disponibilidade_funcionario df ON d.cd_disponibilidade = df.cd_disponibilidade_funcionario
    WHERE 
        df.nm_email_funcionario = funcionarioEmail
        AND d.dt_inicio_disponibilidade <= data
        AND d.dt_fim_disponibilidade >= data
        AND d.nm_periodo_disponibilidade = CASE 
            WHEN periodo = 1 THEN 'Manhã'  
            WHEN periodo = 2 THEN 'Tarde'   
            WHEN periodo = 3 THEN 'Noite'   
            ELSE NULL
        END
        AND h.disponivel = 1 
    ORDER BY 
        h.horario;
END $$


DROP PROCEDURE IF EXISTS BuscarPeriodoPorDia$$
CREATE PROCEDURE BuscarPeriodoPorDia(in pEmail varchar(200) , in pData Date)
BEGIN
	Select df.cd_disponibilidade_funcionario, df.nm_email_funcionario, d.dt_inicio_disponibilidade, d.nm_periodo_disponibilidade from disponibilidade_funcionario df
	join disponibilidade d on (d.cd_disponibilidade = df.cd_disponibilidade_funcionario)
	where df.nm_email_funcionario = pEmail and d.dt_inicio_disponibilidade = pData;
END $$

DELIMITER $$

DROP PROCEDURE IF EXISTS LoginFuncionario$$
CREATE PROCEDURE LoginFuncionario(
    IN p_email_funcionario VARCHAR(50),
    IN p_senha_funcionario VARCHAR(8)
)
BEGIN
    DECLARE v_mensagem BOOLEAN DEFAULT FALSE;

 
    IF EXISTS (
        SELECT 1 FROM funcionario 
        WHERE nm_email_funcionario = p_email_funcionario 
        AND nm_senha = p_senha_funcionario
    ) THEN
        SET v_mensagem = TRUE;
    END IF;

 
    SELECT v_mensagem AS mensagem;
END $$

DELIMITER $$
DROP PROCEDURE IF EXISTS LoginCliente$$
CREATE PROCEDURE LoginCliente(
    IN p_email_cliente VARCHAR(50),
    IN p_senha_cliente VARCHAR(8)
)
BEGIN
    DECLARE v_mensagem BOOLEAN DEFAULT FALSE;

   
    IF EXISTS (
        SELECT 1 FROM cliente 
        WHERE nm_email_cliente = p_email_cliente 
        AND nm_senha = p_senha_cliente
    ) THEN
        SET v_mensagem = TRUE;
    END IF;

  
    SELECT v_mensagem AS mensagem;
END $$ 

DROP PROCEDURE IF EXISTS CadastroFuncionario$$
CREATE PROCEDURE CadastroFuncionario (
    IN p_email_funcionario VARCHAR(50),
    IN p_nome_funcionario VARCHAR(200),
    IN p_senha_funcionario VARCHAR(8),
    IN p_telefone_funcionario VARCHAR(13),
    IN p_endereco_funcionario VARCHAR(300),
    IN p_cargo_funcionario VARCHAR(100)
)
BEGIN
    INSERT INTO Funcionario (nm_email_funcionario, nm_funcionario, nm_senha, nm_telefone, nm_endereco, nm_cargo)
    VALUES (p_email_funcionario, p_nome_funcionario, p_senha_funcionario, p_telefone_funcionario, p_endereco_funcionario, p_cargo_funcionario);
END$$

DROP PROCEDURE IF EXISTS ConsultarPeriodoDisponivel$$
CREATE PROCEDURE ConsultarPeriodoDisponivel(pEmail varchar(50))
BEGIN
    select d.nm_periodo_disponibilidade from disponibilidade d
	join disponibilidade_funcionario df on (df.cd_disponibilidade_funcionario = d.cd_disponibilidade)
	where df.nm_email_funcionario = pEmail group by d.nm_periodo_disponibilidade;
END $$

DELIMITER $$
DROP PROCEDURE IF EXISTS BuscarDisponibilidade$$
CREATE PROCEDURE BuscarDisponibilidade(
    IN p_email_funcionario VARCHAR(255),
    IN p_data_disponibilidade DATE,
    IN p_periodo_disponibilidade VARCHAR(20),
    IN p_codigo_servico INT
)
BEGIN
    SELECT hr_inicio_disponibilidade, 
           hr_fim_disponibilidade, 
           qt_tempo_servico
    FROM disponibilidade d
    JOIN disponibilidade_funcionario df ON d.cd_disponibilidade = df.cd_disponibilidade_funcionario
    JOIN especialidade_funcionario ef ON ef.nm_email_funcionario = df.nm_email_funcionario
    JOIN servico s ON ef.cd_servico = s.cd_servico
    WHERE d.dt_inicio_disponibilidade >= CURDATE()
      AND df.nm_email_funcionario = p_email_funcionario
      AND d.dt_inicio_disponibilidade = p_data_disponibilidade
      AND d.nm_periodo_disponibilidade = p_periodo_disponibilidade
      AND s.cd_servico = p_codigo_servico;
END $$
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

DROP PROCEDURE IF EXISTS ConsultarHorariosAgendamentos$$
CREATE PROCEDURE ConsultarHorariosAgendamentos(
    IN p_data_agendamento DATE,
    IN p_email_funcionario VARCHAR(50)
)
BEGIN
	SELECT hr_agendamento, qt_tempo_servico
    FROM agendamento ag
    join servico s on (s.cd_servico = ag.cd_servico)
    WHERE dt_agendamento = p_data_agendamento 
      AND nm_email_funcionario = p_email_funcionario;
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

DELIMITER $$

DROP PROCEDURE IF EXISTS ConsultarAgendamentosPorData$$

CREATE PROCEDURE ConsultarAgendamentosPorData(IN p_dt_agendamento DATE)
BEGIN
    SELECT 
        a.hr_agendamento,
        s.nm_servico,
        c.nm_cliente,
        f.nm_funcionario
    FROM 
        agendamento a
    JOIN 
        servico s ON a.cd_servico = s.cd_servico
    JOIN 
        cliente c ON a.nm_email_cliente = c.nm_email_cliente
    JOIN 
        funcionario f ON a.nm_email_funcionario = f.nm_email_funcionario
    WHERE 
        DATE(a.dt_agendamento) = p_dt_agendamento;
END $$

DELIMITER ;
