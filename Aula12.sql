/*17/05/2024*/

/**TAREFA**/
CREATE TABLE LINK_FISICO(
	LINK_FISICO_ID INTEGER NOT NULL AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	TIPO VARCHAR(30),
	PORTA_ID_A INT NOT NULL,
	PORTA_ID_B INT NOT NULL,
	PRIMARY KEY(LINK_FISICO_ID)
);

CREATE UNIQUE INDEX IDX_NOME_UNIQUE_001 ON LINK_FISICO (NOME);

ALTER TABLE LINK_FISICO ADD CONSTRAINT FK_PORTA_A FOREIGN KEY (PORTA_ID_A) REFERENCES PORTA (PORTA_ID);

ALTER TABLE LINK_FISICO ADD CONSTRAINT FK_PORTA_B FOREIGN KEY (PORTA_ID_B) REFERENCES PORTA (PORTA_ID);

/**AULA**/
---1) RELATÓRIO PLANO DE SAÚDE SIMPLIFICADO
--- COLUNAS: NOME, DATA_NASCIMENTO
--- OBJETIVO: TRAZER TODOS OS FUNCIONÁRIOS E SEUS DEPENDENTES
--- NOME: VW_RELAT_SIMPLIF

CREATE VIEW VW_RELAT_SIMPLIF AS
	SELECT PNOME AS NOME,
		DATANASC AS DATA_NASCIMENTO
	FROM FUNCIONARIO
	UNION
	SELECT NOME_DEPENDENTE,
		DATA_NASC
	FROM DEPENDENTE;
	
SELECT * FROM VW_RELAT_SIMPLIF;

---2) RELATÓRIO PLANO DE SAÚDE
--- COLUNAS: CPF_RESPONSAVEL, NOME, DATA_NASCIMENTO, TIPO, TIPO DEVE SER: TITULAR OU DEPENDENTE
--- OBJETIVO: TRAZER TODOS OS FUNCIONÁRIOS E SEUS DEPENDENTES, INCLUINDO O CPF DO RESPONSÁVEL EM TODAS AS LINHAS

CREATE VIEW VW_RELAT_COMP AS
	SELECT F.CPF AS CPF_RESPONSAVEL,
		F.PNOME AS NOME,
		F.DATANASC AS DATA_NASCIMENTO,
		'TITULAR' AS TIPO
	FROM FUNCIONARIO F
	UNION
	SELECT D.FCPF,
		D.NOME_DEPENDENTE,
		D.DATA_NASC,
		'DEPENDENTE'
	FROM DEPENDENTE D;

SELECT * FROM VW_RELAT_COMP;

---3) INCLUA NO RELATÓRIO (2) O NOME DO RESPONSÁVEL EM TODAS AS LINHAS DE 2(DUAS) FORMAS DIFERENTES

CREATE VIEW VW_RELAT_COMP_F1 AS
	SELECT F.PNOME AS NOME_RESPONSAVEL,
		   F.CPF AS CPF_RESPONSAVEL,
		   F.PNOME AS NOME,
		   F.DATANASC AS DATA_NASCIMENTO,
		   'TITULAR' AS TIPO
	FROM FUNCIONARIO F
	UNION
	SELECT D.FCPF,
		   D.NOME_DEPENDENTE,
		   D.DATA_NASC,
		   'DEPENDENTE',
		   (SELECT F.PNOME FROM FUNCIONARIO F WHERE F.CPF = D.FCPF)
	FROM DEPENDENTE D;

SELECT * FROM VW_RELAT_COMP_F1;

CREATE VIEW VW_RELAT_COMP_F2 AS
	SELECT F.PNOME AS NOME_RESPONSAVEL,
       F.CPF AS CPF_RESPONSAVEL,
       F.PNOME AS NOME,
       F.DATANASC AS DATA_NASCIMENTO,
       'TITULAR' AS TIPO
	FROM FUNCIONARIO F
	UNION
	SELECT D.FCPF,
		   D.NOME_DEPENDENTE,
		   D.DATA_NASC,
		   'DEPENDENTE',
		   (SELECT F.PNOME FROM FUNCIONARIO F WHERE F.CPF = D.FCPF)
	FROM DEPENDENTE D, FUNCIONARIO F
	WHERE F.CPF = D.FCPF;

SELECT * FROM VW_RELAT_COMP_F2;

--- EXPLAIN QUERY (TRAZ O CUSTO DE EXECUÇÃO DA QUERY)

--- TRIGGER
--- GATILHO, EVENTO NO DB QUE DISPARA UMA DETERMINADA AÇÃO.

--- INSERT (ACEITA APENAS NEW)
--- UPDATE (ACEITA NEW E OLD)
--- DELETE (ACEITA APENAS OLD)

DELIMITER $
CREATE FUNCTION FNC_BUSCA_SITE 
(P_PORTA_ID IN DECIMAL)
RETURNS VARCHAR
BEGIN
	V_SITE_NOME VARCHAR(30);
	SELECT SITE_NOME
		INTO V_SITE_NOME
		FROM PORTA P
	WHERE P.PORTA_ID = P_PORTA_ID;
	
	RETURN V_SITE_NOME
	
END$
DELIMITER ;

SELECT FNC_BUSCA_SITE(1);
--- PORTAS DE 1 A 15000
--- A FUNÇÃO DEVE SER CRIADA PRIMEIRO DO QUE A TRIGGER


--- TESTAR A TRIGGER
INSERT INTO LINK_FISICO(ID, NOME, PORTA_ID_A, PORTA_ID_B);
	VALUES (NULL, NULL, 1, 15000);