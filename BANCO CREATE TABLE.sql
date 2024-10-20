Drop Schema if exists BancoTCC04;
Create Schema BancoTCC04;
use BancoTCC04;


CREATE TABLE Cliente (
    
    nm_email_cliente VARCHAR(50),
    nm_cliente VARCHAR(200),
    nm_senha VARCHAR(8),
    nm_endereco VARCHAR(300),
    ds_cliente TEXT,
    CONSTRAINT pk_cliente PRIMARY KEY (nm_email_cliente)
);



CREATE TABLE Funcionario (
    nm_email_funcionario VARCHAR(50),
    nm_funcionario VARCHAR(200),
    nm_senha VARCHAR(8),
    nm_telefone VARCHAR(13),
    nm_endereco VARCHAR(300),
    nm_cargo VARCHAR(100),
    CONSTRAINT pk_funcionario PRIMARY KEY (nm_email_funcionario)
);

CREATE TABLE Gerente (
    nm_email_gerente VARCHAR(50),
    nm_gerente VARCHAR(200),
    nm_senha VARCHAR(8),
    nm_telefone VARCHAR(13),
    nm_endereco VARCHAR(300),
    nm_departamento VARCHAR(100),
    CONSTRAINT pk_gerente PRIMARY KEY (nm_email_gerente)
);

CREATE TABLE Disponibilidade (
  cd_disponibilidade INT,
  dt_inicio_disponibilidade DATE,
  hr_inicio_disponibilidade TIME,
  dt_fim_disponibilidade DATE,
  hr_fim_disponibilidade TIME,
  nm_periodo_disponibilidade varchar(45),
  CONSTRAINT pk_disponibilidade PRIMARY KEY (cd_disponibilidade)
);


CREATE TABLE Disponibilidade_funcionario (
    cd_disponibilidade_funcionario INT,
    nm_email_funcionario VARCHAR(50),
    PRIMARY KEY (cd_disponibilidade_funcionario, nm_email_funcionario),
    CONSTRAINT fk_disponibilidade_funcionario FOREIGN KEY (cd_disponibilidade_funcionario) REFERENCES disponibilidade(cd_disponibilidade), 
    CONSTRAINT fk_email_funcionario FOREIGN KEY (nm_email_funcionario) REFERENCES funcionario(nm_email_funcionario)
);


Create Table Categoria (
    cd_categoria INT,
    nm_categoria varchar(100),
    constraint pk_categoria primary key (cd_categoria)
);

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
    nm_fornecedor_produto VARCHAR(100),
    CONSTRAINT pk_produto PRIMARY KEY (cd_produto)
);


Create Table Servico (
    cd_servico INT,
    nm_servico varchar(100),
    ds_servico TEXT,
    vl_servico decimal(10 , 2 ),
    qt_tempo_servico TIME,
    cd_categoria INT,
    constraint pk_servico primary key (cd_servico),
    constraint fk_servico_categoria foreign key (cd_categoria)
        references categoria (cd_categoria)
);


CREATE TABLE Especialidade_funcionario (
    nm_email_funcionario VARCHAR(50),
    cd_servico INT,
    CONSTRAINT pk_especialidade_funcionario PRIMARY KEY (nm_email_funcionario , cd_servico),

    CONSTRAINT fk_especialidade_funcionario_funcionario FOREIGN KEY (nm_email_funcionario)
        REFERENCES Funcionario (nm_email_funcionario),

    CONSTRAINT fk_especialidade_funcionario_servico FOREIGN KEY (cd_servico)
        REFERENCES Servico (cd_servico)
);


CREATE TABLE Agendamento (
    cd_agendamento INT AUTO_INCREMENT,
	cd_servico INT,
    hr_agendamento TIME,
    dt_agendamento DATE,
    nm_email_cliente VARCHAR(50),
    nm_email_funcionario VARCHAR(50),
	

    CONSTRAINT pk_agendamento PRIMARY KEY (cd_agendamento, hr_agendamento, dt_agendamento),
    CONSTRAINT fk_agendamento_cliente FOREIGN KEY (nm_email_cliente)
        REFERENCES Cliente (nm_email_cliente),

    CONSTRAINT fk_agendamento_funcionario FOREIGN KEY (nm_email_funcionario)
        REFERENCES Funcionario (nm_email_funcionario)
  
);


Create table Itens_agendamento (
    cd_agendamento INT,
    cd_produto INT,
    cd_servico INT,
	hr_agendamento time, 
	dt_agendamento date,
    constraint pk_itens_agendamento primary key (cd_agendamento, cd_produto, cd_servico, hr_agendamento, dt_agendamento)
);


CREATE TABLE Feedback (
    nm_email_cliente VARCHAR(50),
	cd_agendamento INT,
    cd_feedback INT,
    ds_feedback TEXT,
    dt_feedback DATE,
    hr_feedback TIME,
    CONSTRAINT pk_feedback PRIMARY KEY (cd_feedback, cd_agendamento),
    CONSTRAINT fk_feedback_cliente FOREIGN KEY (nm_email_cliente)
        REFERENCES Cliente (nm_email_cliente)
);


-- Store Procedures --



-- Procedures Funcionário --


-- Atualizar Disponibilidade de um Funcionário
DELIMITER $$

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



-- Cadastrar Funcionário
DELIMITER $$

CREATE PROCEDURE CadastrarFuncionario(
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_nm_funcionario VARCHAR(200),
    IN p_nm_senha VARCHAR(45),
    IN p_nm_telefone VARCHAR(13),
    IN p_nm_endereco VARCHAR(300),
    IN p_nm_cargo VARCHAR(100)
)
BEGIN
    INSERT INTO Funcionario (nm_email_funcionario, nm_funcionario, nm_senha, nm_telefone, nm_endereco, nm_cargo)
    VALUES (p_nm_email_funcionario, p_nm_funcionario, p_nm_senha, p_nm_telefone, p_nm_endereco, p_nm_cargo);
END $$


-- Consultar Disponibilidade de um Funcionário 
DELIMITER $$

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

-- Consultar Funcionarios
DELIMITER $$

CREATE PROCEDURE ConsultarFuncionarios()
BEGIN
    SELECT nm_email_funcionario, nm_funcionario, nm_telefone, nm_endereco
    FROM Funcionario;

END $$


-- Atualizar um funcionário
DELIMITER $$

CREATE PROCEDURE AtualizarFuncionario(
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_nm_funcionario VARCHAR(200),
    IN p_nm_senha VARCHAR(45),
    IN p_nm_telefone VARCHAR(13),
    IN p_nm_endereco VARCHAR(300),
    IN p_nm_cargo VARCHAR(100)
)
BEGIN
    UPDATE Funcionario
    SET nm_funcionario = p_nm_funcionario, 
        nm_senha = p_nm_senha,
        nm_telefone = p_nm_telefone,
        nm_endereco = p_nm_endereco,
        nm_cargo = p_nm_cargo
    WHERE nm_email_funcionario = p_nm_email_funcionario;
END $$

-- Atualizar a disponibilidade do funcionário se estiver livre
DELIMITER $$

DROP PROCEDURE IF EXISTS atualizarDisponibilidadeFuncionarioSeLivre$$
CREATE PROCEDURE atualizarDisponibilidadeFuncionarioSeLivre(
    IN p_cd_disponibilidade_funcionario INT,
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_cd_disponibilidade INT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se o funcionário está disponível para a nova disponibilidade
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


-- Consultar Agendamentos de um Funcionário
DELIMITER $$

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


-- Consultar todos os Funcionários
DELIMITER $$

CREATE PROCEDURE ConsultarTodosFuncionarios()
BEGIN
    SELECT nm_email_funcionario, nm_funcionario, nm_telefone, nm_endereco, nm_cargo
    FROM Funcionario;
END $$

-- Procedures Funcionário Acaba aqui --


-- Procedures Cliente --


-- Inserir um Cliente
DELIMITER $$

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

CREATE PROCEDURE AdicionarHistoricoCliente(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_ds_historico_cliente TEXT
)
BEGIN
    UPDATE Cliente
    SET ds_historico_cliente = CONCAT(ds_historico_cliente, '\n', p_ds_historico_cliente)
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$

-- Procedures Cliente Acaba aqui --



-- Procedures Feedback --


-- Adicionar Feedback
DELIMITER $$

CREATE PROCEDURE AdicionarFeedback(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_ds_feedback TEXT,
    IN p_cd_agendamento INT,
    IN p_hr_feedback TIME
)
BEGIN
    INSERT INTO Feedback (nm_email_cliente, ds_feedback, cd_agendamento, hr_feedback)
    VALUES (p_nm_email_cliente, p_ds_feedback, p_cd_agendamento, p_hr_feedback);
END $$


-- Consultar Feedbacks
DELIMITER $$

CREATE PROCEDURE ConsultarFeedbacks()
BEGIN
    SELECT cd_feedback, nm_email_cliente, ds_feedback, cd_agendamento, hr_feedback
    FROM Feedback;
END $$

-- Adicionar um feedback somente se o agendamento existir
DELIMITER $$

DROP PROCEDURE IF EXISTS adicionarFeedbackSeAgendamentoExistir$$
CREATE PROCEDURE adicionarFeedbackSeAgendamentoExistir(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_ds_feedback TEXT,
    IN p_cd_agendamento INT,
    IN p_hr_feedback TIME
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se o agendamento existe
    SELECT COUNT(*) INTO qtd FROM Agendamento WHERE cd_agendamento = p_cd_agendamento;

    IF qtd > 0 THEN
        INSERT INTO Feedback (nm_email_cliente, ds_feedback, cd_agendamento, hr_feedback)
        VALUES (p_nm_email_cliente, p_ds_feedback, p_cd_agendamento, p_hr_feedback);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Agendamento não encontrado';
    END IF;
END $$

-- Consultar Feedbacks por Cliente
DELIMITER $$

CREATE PROCEDURE ConsultarFeedbacksPorCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    SELECT cd_feedback, ds_feedback, cd_agendamento, hr_feedback
    FROM Feedback
    WHERE nm_email_cliente = p_nm_email_cliente;
END $$


-- Excluir Feedback 
DELIMITER $$

CREATE PROCEDURE ExcluirFeedback(
    IN p_cd_feedback INT
)
BEGIN
    DELETE FROM Feedback
    WHERE cd_feedback = p_cd_feedback;
END $$


-- Editar Feedback
DELIMITER $$

CREATE PROCEDURE EditarFeedback(
    IN p_cd_feedback INT,
    IN p_ds_feedback TEXT
)
BEGIN
    UPDATE Feedback
    SET ds_feedback = p_ds_feedback
    WHERE cd_feedback = p_cd_feedback;
END $$


-- Procedures Feedback Acaba aqui --



-- Procedures Serviço --


-- Inserir um Serviço
DELIMITER $$

CREATE PROCEDURE InserirServico(
    IN p_nm_servico VARCHAR(100),
    IN p_ds_servico TEXT,
    IN p_vl_servico DECIMAL(10,2),
    IN p_qt_tempo_servico TIME,
    IN p_cd_categoria INT
)
BEGIN
    INSERT INTO Servico (nm_servico, ds_servico, vl_servico, qt_tempo_servico, cd_categoria)
    VALUES (p_nm_servico, p_ds_servico, p_vl_servico, p_qt_tempo_servico, p_cd_categoria);
END $$



-- Atualizar Serviço 
DELIMITER $$

CREATE PROCEDURE AtualizarServico(
    IN p_cd_servico INT,
    IN p_nm_servico VARCHAR(100),
    IN p_ds_servico TEXT,
    IN p_vl_servico DECIMAL(10,2),
    IN p_qt_tempo_servico TIME,
    IN p_cd_categoria INT
)
BEGIN
    UPDATE Servico
    SET nm_servico = p_nm_servico, 
        ds_servico = p_ds_servico,
        vl_servico = p_vl_servico,
        qt_tempo_servico = p_qt_tempo_servico,
        cd_categoria = p_cd_categoria
    WHERE cd_servico = p_cd_servico;
END $$


-- Consultar Serviços
DELIMITER $$

CREATE PROCEDURE ConsultarServicos()
BEGIN
    SELECT cd_servico, nm_servico, ds_servico, vl_servico, qt_tempo_servico, cd_categoria
    FROM Servico;
END $$


-- Adicionar um novo serviço
DROP PROCEDURE IF EXISTS adicionarServico$$
CREATE PROCEDURE adicionarServico(
    IN p_nm_servico VARCHAR(100),
    IN p_ds_servico TEXT,
    IN p_vl_servico DECIMAL(10,2),
    IN p_qt_tempo_servico TIME,
    IN p_cd_categoria INT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se o serviço já existe
    SELECT COUNT(*) INTO qtd FROM Servico WHERE nm_servico = p_nm_servico;

    IF qtd = 0 THEN
        INSERT INTO Servico (nm_servico, ds_servico, vl_servico, qt_tempo_servico, cd_categoria)
        VALUES (p_nm_servico, p_ds_servico, p_vl_servico, p_qt_tempo_servico, p_cd_categoria);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Serviço já cadastrado';
    END IF;
END $$


-- Buscar serviços por faixa de preço
DELIMITER $$

DROP PROCEDURE IF EXISTS buscarServicosPorFaixaDePreco$$
CREATE PROCEDURE buscarServicosPorFaixaDePreco(
    IN p_preco_min DECIMAL(10,2),
    IN p_preco_max DECIMAL(10,2)
)
BEGIN
    SELECT cd_servico, nm_servico, ds_servico, vl_servico, qt_tempo_servico
    FROM Servico
    WHERE vl_servico BETWEEN p_preco_min AND p_preco_max;
END $$

DELIMITER $$


-- Excluir um serviço somente se não houver agendamentos
DELIMITER $$

DROP PROCEDURE IF EXISTS excluirServicoSeNaoExistiremAgendamentos$$
CREATE PROCEDURE excluirServicoSeNaoExistiremAgendamentos(
    IN p_cd_servico INT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se o serviço possui agendamentos
    SELECT COUNT(*) INTO qtd FROM Agendamento WHERE cd_servico = p_cd_servico;

    IF qtd = 0 THEN
        DELETE FROM Servico
        WHERE cd_servico = p_cd_servico;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Serviço não pode ser excluído porque possui agendamentos';
    END IF;
END $$


-- Atualizar um serviço existente
DROP PROCEDURE IF EXISTS atualizarServico$$
CREATE PROCEDURE atualizarServico(
    IN p_cd_servico INT,
    IN p_nm_servico VARCHAR(100),
    IN p_ds_servico TEXT,
    IN p_vl_servico DECIMAL(10,2),
    IN p_qt_tempo_servico TIME,
    IN p_cd_categoria INT
)
BEGIN
    UPDATE Servico
    SET nm_servico = p_nm_servico,
        ds_servico = p_ds_servico,
        vl_servico = p_vl_servico,
        qt_tempo_servico = p_qt_tempo_servico,
        cd_categoria = p_cd_categoria
    WHERE cd_servico = p_cd_servico;
END $$


-- Adicionar um novo serviço
DROP PROCEDURE IF EXISTS adicionarServico$$
CREATE PROCEDURE adicionarServico(
    IN p_nm_servico VARCHAR(100),
    IN p_ds_servico TEXT,
    IN p_vl_servico DECIMAL(10,2),
    IN p_qt_tempo_servico TIME,
    IN p_cd_categoria INT
)
BEGIN
    DECLARE qtd INT DEFAULT 0;

    -- Verificar se o serviço já existe
    SELECT COUNT(*) INTO qtd FROM Servico WHERE nm_servico = p_nm_servico;

    IF qtd = 0 THEN
        INSERT INTO Servico (nm_servico, ds_servico, vl_servico, qt_tempo_servico, cd_categoria)
        VALUES (p_nm_servico, p_ds_servico, p_vl_servico, p_qt_tempo_servico, p_cd_categoria);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Serviço já cadastrado';
    END IF;
END $$


-- Atualizar Disponibilidade de um Serviço
DELIMITER $$

CREATE PROCEDURE AtualizarDisponibilidadeServico(
    IN p_cd_servico INT,
    IN p_dt_disponibilidade DATE,
    IN p_hr_inicio TIME,
    IN p_hr_fim TIME
)
BEGIN
    UPDATE Disponibilidade_servico
    SET dt_disponibilidade = p_dt_disponibilidade,
        hr_inicio = p_hr_inicio,
        hr_fim = p_hr_fim
    WHERE cd_servico = p_cd_servico;
END $$


-- Verificar Disponibilidade de um Serviço
DELIMITER $$

CREATE PROCEDURE VerificarDisponibilidadeServico(
    IN p_cd_servico INT,
    IN p_dt_agendamento DATE,
    IN p_hr_agendamento TIME
)
BEGIN
    DECLARE disponibilidade BOOLEAN;

    SELECT COUNT(*)
    INTO disponibilidade
    FROM Agendamento
    WHERE cd_servico = p_cd_servico
      AND dt_agendamento = p_dt_agendamento
      AND hr_agendamento = p_hr_agendamento;

    IF disponibilidade > 0 THEN
        SELECT 'O serviço não está disponível no horário solicitado.' AS Mensagem;
    ELSE
        SELECT 'O serviço está disponível no horário solicitado.' AS Mensagem;
    END IF;
END $$


-- Consultar Serviços por Nome
DELIMITER $$

CREATE PROCEDURE ConsultarServicosPorNome(
    IN p_nm_servico VARCHAR(100)
)
BEGIN
    SELECT cd_servico, nm_servico, ds_servico, vl_servico, qt_tempo_servico, cd_categoria
    FROM Servico
    WHERE nm_servico LIKE CONCAT('%', p_nm_servico, '%');
END $$


-- Consultar Serviços por Categoria
DELIMITER $$

CREATE PROCEDURE ConsultarServicosPorCategoria(
    IN p_cd_categoria INT
)
BEGIN
    SELECT cd_servico, nm_servico, ds_servico, vl_servico, qt_tempo_servico
    FROM Servico
    WHERE cd_categoria = p_cd_categoria;
END $$

-- Procedures Serviço acaba aqui --



-- Procedures Agendamento --


-- Marcar Agendamento
DELIMITER $$

CREATE PROCEDURE MarcarAgendamento(
    IN p_nm_email_cliente VARCHAR(50),
    IN p_nm_email_funcionario VARCHAR(50),
    IN p_cd_servico INT,
    IN p_dt_agendamento DATE,
    IN p_hr_agendamento TIME
)
BEGIN
    INSERT INTO Agendamento (nm_email_cliente, nm_email_funcionario, cd_servico, dt_agendamento, hr_agendamento)
    VALUES (p_nm_email_cliente, p_nm_email_funcionario, p_cd_servico, p_dt_agendamento, p_hr_agendamento);
END $$


-- Excluir Agendamento 
DELIMITER $$

CREATE PROCEDURE ExcluirAgendamento(
    IN p_cd_agendamento INT
)
BEGIN
    DELETE FROM Agendamento
    WHERE cd_agendamento = p_cd_agendamento;
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


-- Consultar Agendamentos por Cliente
DELIMITER $$

CREATE PROCEDURE ConsultarAgendamentosPorCliente(
    IN p_nm_email_cliente VARCHAR(50)
)
BEGIN
    SELECT a.cd_agendamento, a.dt_agendamento, a.hr_agendamento, f.nm_funcionario, s.nm_servico
    FROM Agendamento a
    JOIN Funcionario f ON a.nm_email_funcionario = f.nm_email_funcionario
    JOIN Servico s ON a.cd_servico = s.cd_servico
    WHERE a.nm_email_cliente = p_nm_email_cliente;
END $$


-- Consultar Agendamentos por Data
DELIMITER $$

CREATE PROCEDURE ConsultarAgendamentosPorData(
    IN p_dt_agendamento DATE
)
BEGIN
    SELECT a.cd_agendamento, a.hr_agendamento, c.nm_cliente, f.nm_funcionario, s.nm_servico
    FROM Agendamento a
    JOIN Cliente c ON a.nm_email_cliente = c.nm_email_cliente
    JOIN Funcionario f ON a.nm_email_funcionario = f.nm_email_funcionario
    JOIN Servico s ON a.cd_servico = s.cd_servico
    WHERE a.dt_agendamento = p_dt_agendamento;
END $$


-- Consultar todos os agendamentos
DELIMITER $$

CREATE PROCEDURE ConsultarTodosAgendamentos()
BEGIN
    SELECT a.cd_agendamento, a.dt_agendamento, a.hr_agendamento, 
           c.nm_cliente, f.nm_funcionario, s.nm_servico
    FROM Agendamento a
    JOIN Cliente c ON a.nm_email_cliente = c.nm_email_cliente
    JOIN Funcionario f ON a.nm_email_funcionario = f.nm_email_funcionario
    JOIN Servico s ON a.cd_servico = s.cd_servico;
END $$


-- Procedures Agendamento acaba aqui --



-- Procedures Categoria --


-- Consultar Categorias
DELIMITER $$

CREATE PROCEDURE ConsultarCategorias()
BEGIN
    SELECT cd_categoria, nm_categoria, ds_categoria
    FROM Categoria;
END $$



-- Inserir Categoria
DELIMITER $$

CREATE PROCEDURE InserirCategoria(
    IN p_nm_categoria VARCHAR(100),
    IN p_ds_categoria TEXT
)
BEGIN
    INSERT INTO Categoria (nm_categoria, ds_categoria)
    VALUES (p_nm_categoria, p_ds_categoria);
END $$


-- Atualizar Categoria
DELIMITER $$

CREATE PROCEDURE AtualizarCategoria(
    IN p_cd_categoria INT,
    IN p_nm_categoria VARCHAR(100),
    IN p_ds_categoria TEXT
)
BEGIN
    UPDATE Categoria
    SET nm_categoria = p_nm_categoria, 
        ds_categoria = p_ds_categoria
    WHERE cd_categoria = p_cd_categoria;
END $$



-- Excluir Categoria
DELIMITER $$

CREATE PROCEDURE ExcluirCategoria(
    IN p_cd_categoria INT
)
BEGIN
    DELETE FROM Categoria
    WHERE cd_categoria = p_cd_categoria;
END $$

-- Procedures Categoria acaba aqui --


DROP PROCEDURE IF EXISTS LoginGerente$$
CREATE PROCEDURE LoginGerente(
    IN p_email_gerente VARCHAR(50),
    IN p_senha_gerente VARCHAR(8)
)
BEGIN
    DECLARE v_mensagem BOOLEAN DEFAULT FALSE;

    IF EXISTS (
        SELECT 1 FROM Gerente
        WHERE nm_email_gerente = p_email_gerente 
        AND nm_senha = p_senha_gerente 
    ) THEN
        SET v_mensagem = TRUE;
    END IF;

    -- Retorna o resultado da verificação
    SELECT v_mensagem AS mensagem;
END $$


Delimiter ;




































