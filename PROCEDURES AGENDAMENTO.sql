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
            WHEN periodo = 1 THEN 'Manhã'   -- Exemplo: período 1 representa manhã
            WHEN periodo = 2 THEN 'Tarde'   -- Exemplo: período 2 representa tarde
            WHEN periodo = 3 THEN 'Noite'   -- Exemplo: período 3 representa noite
            ELSE NULL
        END
        AND h.disponivel = 1 -- Assume que existe uma coluna 'disponivel' que indica se o horário está disponível
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

    -- Retorna o resultado da verificação
    SELECT v_mensagem AS mensagem;
END $$

DELIMITER $$

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

    -- Retorna o resultado da verificação
    SELECT v_mensagem AS mensagem;
END $$ 


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

DELIMITER ;

call AgendarServico("ana.oliveira@email.com", 0, current_time(), curdate(), "anaclara@gmail.com");
call ConsultarDataDisponibilidadeFuncionario('anaclara@gmail.com');
call sp_ObterHorariosDisponiveis();

select hr_inicio_disponibilidade
    from disponibilidade d
join disponibilidade_funcionario df on (d.cd_disponibilidade = df.cd_disponibilidade_funcionario)
    Where dt_inicio_disponibilidade >= curdate() and df.nm_email_funcionario = "roberto.pereira@email.com" and dt_inicio_disponibilidade = "2024-11-14" and nm_periodo_disponibilidade="Tarde";

select * from disponibilidade_funcionario;



CALL ConsultarDisponibilidadeFuncionario('ana.oliveira@email.com', 1);
