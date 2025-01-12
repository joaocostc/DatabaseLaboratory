/*12/04/2024*/

-- INSTRUÇÕES DA TAREFA PARA (19/04/2024)
--- (1) CREATE PROC;
--- (2) SELECT COUNT(*) FROM PLACA;
--- (3) SET @VAR_QTDE=0;
--- (4) CALL PRC_CARGA_PLACA(@VAR_QTDE);
--- (5) SELECT COUNT(*) FROM PLACA; (PRECISA RETORNAR 240)
--- (6) SELECT @VAR_QTDE; (PRECISA RETORNAR 240)

-- CRIAR UM NOVO BANCO DE DADOS
CREATE DATABASE EMPRESA;

-- SELECIONA O BANCO DE DADOS A SER UTILIZADO
USE EMPRESA;

-- CRIAÇÃO DA TABELA FUNCIONÁRIO
CREATE TABLE FUNCIONARIO(
PNOME VARCHAR(30) NOT NULL,
MINICIAL VARCHAR(2),
UNOME VARCHAR(15) NOT NULL,
CPF VARCHAR(12) NOT NULL,
ENDERECO VARCHAR(50),
DATANASC VARCHAR(10),
SEXO VARCHAR(2),
SALARIO VARCHAR(10),
CPF_SUPERVISOR VARCHAR(12),
DNR INT,
PRIMARY KEY (CPF)
);

-- ADICIONANDO A CHAVE ESTRANGEIRA CPF_SUPERVISOR NA TABELA FUNCIONARIO, REFERENCIANDO AO ATRIBUTO CPF DA TABELA FUNCIONÁRIO
ALTER TABLE FUNCIONARIO ADD CONSTRAINT FK_CPF_SUPERVISIOR FOREIGN KEY (CPF_SUPERVISOR) REFERENCES FUNCIONARIO(CPF);

-- CRIAÇÃO DA TABELA PROJETO
CREATE TABLE PROJETO ( 
    PROJNUMERO INT PRIMARY KEY, 
    PROJNOME VARCHAR(30), 
    PROJLOCAL VARCHAR(30), 
    DNUM INT 
); 

-- CRIAÇÃO DA TABELA TRABALHA_EM
CREATE TABLE TRABALHA_EM ( 
    PNR INT, 
    HORAS DECIMAL(5, 2), 
    FCPF VARCHAR(12), 
    FOREIGN KEY (FCPF) REFERENCES FUNCIONARIO(CPF), 
    FOREIGN KEY (PNR) REFERENCES PROJETO(PROJNUMERO) 
); 

-- CRIAÇÃO DA TABELA DEPARTAMENTO
CREATE TABLE DEPARTAMENTO ( 
    DNUMERO INT PRIMARY KEY, 
    DNOME VARCHAR(30), 
    CPF_GERENTE VARCHAR(12), 
    DATA_INICIO_GERENTE VARCHAR(10),
    FOREIGN KEY (CPF_GERENTE) REFERENCES FUNCIONARIO(CPF) 
); 

-- CRIAÇÃO DA TABELA DEPENDENTE
CREATE TABLE DEPENDENTE ( 
    FCPF VARCHAR(12), 
    NOME_DEPENDENTE VARCHAR(30), 
    SEXO CHAR(1), 
    DATA_NASC VARCHAR(10), 
    PARENTESCO VARCHAR(30), 
    PRIMARY KEY (FCPF, NOME_DEPENDENTE), 
    FOREIGN KEY (FCPF) REFERENCES FUNCIONARIO(CPF) 
); 

-- CRIAÇÃO DA TABELA LOCALIZACAO_DEP
CREATE TABLE LOCALIZACAO_DEP ( 
    DNUMERO INT, 
    DLOCAL VARCHAR(50), 
    PRIMARY KEY (DNUMERO, DLOCAL), 
    FOREIGN KEY (DNUMERO) REFERENCES DEPARTAMENTO(DNUMERO) 
); 

-- INSERÇÃO DE DADOS NA TABELA FUNCIONÁRIO
INSERT INTO FUNCIONARIO (PNOME, MINICIAL, UNOME, CPF, ENDERECO, DATANASC, SEXO, SALARIO, CPF_SUPERVISOR, DNR)
VALUES('JORGE', 'E', 'BRITO', '88866555576', 'RUA DO HORTO', '10-11-1937', 'M', '55000', NULL, '1');
INSERT INTO FUNCIONARIO (PNOME, MINICIAL, UNOME, CPF, ENDERECO, DATANASC, SEXO, SALARIO, CPF_SUPERVISOR, DNR)
VALUES('FERNANDO', 'T', 'WONG', '33344555587', 'RUA DA LAPA', '08-12-1955', 'M', '40000', '88866555576', '5');
INSERT INTO FUNCIONARIO (PNOME, MINICIAL, UNOME, CPF, ENDERECO, DATANASC, SEXO, SALARIO, CPF_SUPERVISOR, DNR)
VALUES('JOÃO', 'B', 'SILVA', '12345678966', 'RUA DAS FLORES', '09-01-1965', 'M', '30000', '33344555587', '5');
INSERT INTO FUNCIONARIO (PNOME, MINICIAL, UNOME, CPF, ENDERECO, DATANASC, SEXO, SALARIO, CPF_SUPERVISOR, DNR)
VALUES('JENIFER', 'F', 'SOUZA', '98765432168', 'AV. ARTHUR DE LIMA', '20-06-1941', 'F', '43000', '88866555576', '4');
INSERT INTO FUNCIONARIO (PNOME, MINICIAL, UNOME, CPF, ENDERECO, DATANASC, SEXO, SALARIO, CPF_SUPERVISOR, DNR)
VALUES('ALICE', 'J', 'ZELAYA', '99988777767', 'RUA SOUZA LIMA', '19-01-1968', 'F', '25000', '98765432168', '4');
INSERT INTO FUNCIONARIO (PNOME, MINICIAL, UNOME, CPF, ENDERECO, DATANASC, SEXO, SALARIO, CPF_SUPERVISOR, DNR)
VALUES('RONALLDO', 'K', 'LIMA', '66688444476', 'RUA REBOUÇAS', '15-09-1962', 'M', '38000', '33344555587', '5');
INSERT INTO FUNCIONARIO (PNOME, MINICIAL, UNOME, CPF, ENDERECO, DATANASC, SEXO, SALARIO, CPF_SUPERVISOR, DNR)
VALUES('JOICE', 'A', 'LEITE', '45345345376', 'AV. LUCAS OBEC', '31-07-1972', 'F', '25000', '33344555587', '5');
INSERT INTO FUNCIONARIO (PNOME, MINICIAL, UNOME, CPF, ENDERECO, DATANASC, SEXO, SALARIO, CPF_SUPERVISOR, DNR)
VALUES('ANDRÉ', 'V', 'PEREIRA', '98798798733', 'RUA TIMBIRA', '29-03-1969', 'M', '25000', '98765432168', '4');

-- INSERÇÃO DE DADOS NA TABELA DEPENDENTE 
INSERT INTO DEPENDENTE(FCPF, NOME_DEPENDENTE, SEXO, DATA_NASC, PARENTESCO) 
VALUES ('33344555587', 'ALICIA', 'F', '05-04-1986', 'FILHA'); 
INSERT INTO DEPENDENTE(FCPF, NOME_DEPENDENTE, SEXO, DATA_NASC, PARENTESCO) 
VALUES ('33344555587', 'TIAGO', 'M', '25-10-1983', 'FILHO'); 
INSERT INTO DEPENDENTE(FCPF, NOME_DEPENDENTE, SEXO, DATA_NASC, PARENTESCO) 
VALUES ('33344555587', 'JANAÍNA', 'F', '03-05-1958', 'ESPOSA'); 
INSERT INTO DEPENDENTE(FCPF, NOME_DEPENDENTE, SEXO, DATA_NASC, PARENTESCO) 
VALUES ('98765432168', 'ANTONIO', 'M', '28-02-1942', 'MARIDO'); 
INSERT INTO DEPENDENTE(FCPF, NOME_DEPENDENTE, SEXO, DATA_NASC, PARENTESCO) 
VALUES ('12345678966', 'MICHAEL', 'M', '04-01-1988', 'FILHO'); 
INSERT INTO DEPENDENTE(FCPF, NOME_DEPENDENTE, SEXO, DATA_NASC, PARENTESCO) 
VALUES ('12345678966', 'ALICIA', 'F', '30-12-1988', 'FILHA'); 
INSERT INTO DEPENDENTE(FCPF, NOME_DEPENDENTE, SEXO, DATA_NASC, PARENTESCO) 
VALUES ('12345678966', 'ELIZABETH', 'F', '05-05-1967', 'ESPOSA');  

-- INSERÇÃO DE DADOS NA TABELA DEPARTAMENTO
INSERT INTO DEPARTAMENTO(DNOME, DNUMERO, CPF_GERENTE, DATA_INICIO_GERENTE) 
  VALUES ('PESQUISA', '5', '33344555587', '22-06-1988'); 
INSERT INTO DEPARTAMENTO(DNOME, DNUMERO, CPF_GERENTE, DATA_INICIO_GERENTE) 
  VALUES ('ADMINISTRAÇÃO', '4', '98765432168', '01-01-1995'); 
INSERT INTO DEPARTAMENTO(DNOME, DNUMERO, CPF_GERENTE, DATA_INICIO_GERENTE) 
  VALUES ('MATRIZ', '1', '88866555576', '19-06-1981'); 

-- INSERÇÃO DE DADOS NA TABELA PROJETO
INSERT INTO PROJETO(PROJNOME, PROJNUMERO, PROJLOCAL, DNUM) 
VALUES ('PRODUTOX', '1', 'SANTO ANDRÉ', '5'); 
INSERT INTO PROJETO(PROJNOME, PROJNUMERO, PROJLOCAL, DNUM) 
VALUES ('PRODUTOY', '2', 'ITU', '5'); 
INSERT INTO PROJETO(PROJNOME, PROJNUMERO, PROJLOCAL, DNUM) 
VALUES ('PRODUTOZ', '3', 'SÃO PAULO', '5'); 
INSERT INTO PROJETO(PROJNOME, PROJNUMERO, PROJLOCAL, DNUM) 
VALUES ('INFORMATIZAÇÃO', '10', 'MAUÁ', '4'); 
INSERT INTO PROJETO(PROJNOME, PROJNUMERO, PROJLOCAL, DNUM) 
VALUES ('REORGANIZAÇÃO', '20', 'SÃO PAULO', '1'); 
INSERT INTO PROJETO(PROJNOME, PROJNUMERO, PROJLOCAL, DNUM) 
VALUES ('NOVOSBENEFÍCIOS', '30', 'MAUÁ', '4');  

-- INSERÇÃO DE DADOS NA TABELA EM TRABALHA_EM
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('12345678966', '1', '32.5'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('12345678966', '2', '7.5'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('66688444476', '3', '40.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('45345345376', '1', '20.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('45345345376', '2', '20.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('33344555587', '2', '10.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('33344555587', '3', '10.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('33344555587', '10', '10.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('33344555587', '20', '10.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('99988777767', '30', '30.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('99988777767', '10', '10.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('98798798733', '10', '35.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('98798798733', '30', '5.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('98765432168', '30', '20.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('98765432168', '20', '15.0'); 
INSERT INTO TRABALHA_EM(FCPF, PNR, HORAS) 
VALUES ('88866555576', '20', NULL);  

-- INSERÇÃO DE DADOS NA TABELA LOCALIZAÇÃO
INSERT INTO LOCALIZACAO_DEP(DNUMERO, DLOCAL) 
VALUES ('1', 'SÃO PAULO'); 
INSERT INTO LOCALIZACAO_DEP(DNUMERO, DLOCAL) 
VALUES ('4', 'MAUÁ'); 
INSERT INTO LOCALIZACAO_DEP(DNUMERO, DLOCAL) 
VALUES ('5', 'SANTO ANDRÉ'); 
INSERT INTO LOCALIZACAO_DEP(DNUMERO, DLOCAL) 
VALUES ('5', 'ITU'); 
INSERT INTO LOCALIZACAO_DEP(DNUMERO, DLOCAL) 
VALUES ('5', 'SÃO PAULO'); 

-- OPERAÇÃO DE SELEÇÃO
SELECT *
	FROM FUNCIONARIO
WHERE DNR = 4;

-- OPERAÇÃO DE SELEÇÃO
SELECT *
	FROM FUNCIONARIO
WHERE SALARIO > 30000;

-- OPERAÇÃO DE PROJEÇÃO
SELECT UNOME, PNOME, SALARIO
	FROM FUNCIONARIO;
	
-- OPERAÇÃO DE RENOMEAR E SEQUÊNCIA
SELECT * FROM (SELECT PNOME, UNOME, SALARIO
	FROM (SELECT * FROM FUNCIONARIO 
	WHERE DNR = 5) AS FUNCS_DEPT5) AS RESULTADO; 
	
-- OPERAÇÃO DE UNIÃO	
SELECT PNOME, UNOME
	FROM FUNCIONARIO
WHERE DNR = 4
UNION 
SELECT PNOME, UNOME	
	FROM FUNCIONARIO
WHERE DNR = 5;

-- OPERAÇÃO DE INTERSECÇÃO (LEFT JOIN)
SELECT D1.NOME_DEPENDENTE, D1.PARENTESCO
FROM DEPENDENTE D1
INNER JOIN DEPENDENTE D2 ON D1.NOME_DEPENDENTE = D2.NOME_DEPENDENTE
WHERE D1.FCPF = 33344555587
AND D2.FCPF = 12345678966; 


DELIMITER @
CREATE PROCEDURE PRC_CARGA_PLACA (P_QTDE OUT DECIMAL)
	BEGIN
		CURSOR CURS1 FOR
			SELECT EQUIPAMENTO_NOME, SITE_NOME
				FROM EQUIPAMENTO;
		V_QTDE DECIMAL:=0;
		BEGIN
			FOR C1 IN CURS1 LOOP
			INSERT INTO PLACA
			(SLOT, EQUIPAMENTO_NOME, SITE_NOME, SLOT_TIPO)
			VALUES (C1.SLOT, C1.EQUIPAMENTO_NOME, C1.EQUIPAMENTO_NOME, C1.SLOT_TIPO);
			V_QTDE:=V_QTDE+1;
		END LOOP
		P_QTDE:=V_QTDE;
	END@
DELIMITER ;	
	
	
DELIMITER @
CREATE PROCEDURE PRC_CARGA_PLACA (OUT P_QTDE DECIMAL)
BEGIN
    DECLARE DONE INT DEFAULT FALSE;
    DECLARE EQUIP_NOME VARCHAR(30);
    DECLARE SITE_NOME VARCHAR(30);

    -- CURSOR PARA SELECIONAR OS EQUIPAMENTOS DA TABELA EQUIPAMENTO
    DECLARE CUR_EQUIP CURSOR FOR
        SELECT EQUIPAMENTO_NOME, SITE_NOME
        FROM EQUIPAMENTO;

    -- HANDLER PARA ENCERRAR O CURSOR QUANDO NÃO HOUVER MAIS REGISTROS
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;

    -- ABRE O CURSOR PARA SELEÇÃO DE EQUIPAMENTOS
    OPEN CUR_EQUIP;

    -- LOOP PARA INSERIR DADOS NA TABELA PLACA PARA CADA EQUIPAMENTO
    EQUIP_LOOP: LOOP
        FETCH CUR_EQUIP INTO EQUIP_NOME, SITE_NOME;
        IF DONE THEN
            LEAVE EQUIP_LOOP;
        END IF;

        -- INSERE OS DADOS NA TABELA PLACA
        INSERT INTO PLACA (SLOT, EQUIPAMENTO_NOME, SITE_NOME, SLOT_TIPO)
        VALUES ('SLOT_VALUE', EQUIP_NOME, SITE_NOME, 'TIPO_DE_SLOT');

        -- INCREMENTA O CONTADOR DE QUANTIDADE
        SET P_QTDE = P_QTDE + 1;
    END LOOP;

    -- FECHA O CURSOR DE SELEÇÃO DE EQUIPAMENTOS
    CLOSE CUR_EQUIP;
END@