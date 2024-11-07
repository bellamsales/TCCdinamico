
DELIMITER $$

DROP PROCEDURE IF EXISTS ADICIONARSERVICO$$
CREATE PROCEDURE ADICIONARSERVICO(pCodigo int, pNome varchar(255), pValor decimal(10,2), pTempoServico varchar(255))
BEGIN
	INSERT INTO SERVICO (cd_servico, nm_servico, vl_servico, qt_tempo_servico) VALUES (pCodigo, pNome, pValor, pTempoServico);
END$$

DROP PROCEDURE IF EXISTS ADICIONARCODIGO$$
CREATE PROCEDURE ADICIONARCODIGO()
BEGIN
	SELECT COALESCE(MAX(CD_SERVICO+1),1) FROM SERVICO;
END$$





SELECT * FROM SERVICO;


DELIMITER $$

DROP PROCEDURE IF EXISTS ADICIONARSERVICO$$
CREATE PROCEDURE ADICIONARSERVICO(pCodigo int, pNome varchar(255), pValor decimal(10,2), pTempoServico time)
BEGIN
	INSERT INTO SERVICO VALUES (pCodigo, pNome, pValor, pTempoServico);
END$$




Delimiter $$

Drop Procedure if exists ListarServicosCabelo$$
Create Procedure ListarServicosCabelo()
Begin
	Select s.*, c.nm_categoria from servico s
	join categoria c on (c.cd_categoria = s.cd_categoria)
	where s.cd_categoria <= 7;
End$$


Delimiter $$

Drop procedure if exists ListarServicoUnha $$
Create procedure ListarServicoUnha()
Begin

	Select s.*, c.nm_categoria from servico s
	join categoria c on (c.cd_categoria = s.cd_categoria)
	where s.cd_categoria > 7 and s.cd_categoria <= 10 ;

end$$







Delimiter $$

Drop procedure if exists ExcluirServico $$
Create procedure ExcluirServico(pcodigo int)
Begin

DELETE FROM
        Servico
        WHERE
        cd_servico = pcodigo;


end$$




Delimiter $$

Drop procedure if exists BuscarDadosServico$$
Create Procedure BuscarDadosServico(pcodigo int)
Begin
	Select s.*, c.nm_categoria from servico s 
	join categoria c on (c.cd_categoria = s.cd_categoria)
	where s.cd_servico = pcodigo;
End$$



Delimiter $$

Drop procedure if exists AtualizarDadosServico$$
Create Procedure AtualizarDadosServico(pcodigo int, pnome varchar(100), pdescricao text, pvalor decimal (10,2), ptempo time)
Begin
	Update servico set
		nm_servico = pnome,
		ds_servico = pdescricao,
		vl_servico = pvalor,
		qt_tempo_servico = ptempo
	where cd_servico = pcodigo;
End$$

Delimiter ;
