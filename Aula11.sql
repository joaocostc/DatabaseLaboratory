/*10/05/2024*/

-- OPERAÇÃO DE AGREGAÇÃO E AGRUPAMENTO
-- MIN (MÍNIMO)
-- MAX (MÁXIMO)
-- COUNT (QUANTIDADE)
-- AVG (MÉDIA)
-- SUM (SOMA)

USE EMPRESA;

-- CONTANDO O TOTAL DE CPF E A MÉDIA DOS SALÁRIOS AGRUPADOS POR DEPARTAMENTO
SELECT DNR, COUNT(CPF), AVG(SALARIO) FROM FUNCIONARIO GROUP BY DNR;
+------+------------+--------------+
| DNR  | COUNT(CPF) | AVG(SALARIO) |
+------+------------+--------------+
|    1 |          1 |        55000 |
|    4 |          3 |        31000 |
|    5 |          4 |        33250 |
+------+------------+--------------+

-- CONTANDO O TOTAL DE CPF, A MÉDIA DOS SALÁRIOS, MENOR SALÁRIO E O MENOR SALÁRIO AGRUPADOS POR DEPARTAMENTO
SELECT DNR, COUNT(CPF), AVG(SALARIO), MIN(SALARIO), MAX(SALARIO) FROM FUNCIONARIO GROUP BY DNR;
+------+------------+--------------+--------------+--------------+
| DNR  | COUNT(CPF) | AVG(SALARIO) | MIN(SALARIO) | MAX(SALARIO) |
+------+------------+--------------+--------------+--------------+
|    1 |          1 |        55000 | 55000        | 55000        |
|    4 |          3 |        31000 | 25000        | 43000        |
|    5 |          4 |        33250 | 25000        | 40000        |
+------+------------+--------------+--------------+--------------+

-- CONTANDO O TOTAL DE CPF, A MÉDIA DOS SALÁRIOS, MENOR SALÁRIO, MENOR SALÁRIO E CÁLCULO DA MÉDIA DOS SALÁRIO (MANEIRA DIFERENTE) AGRUPADOS POR DEPARTAMENTO
SELECT DNR, COUNT(CPF), AVG(SALARIO), MIN(SALARIO), MAX(SALARIO), SUM(SALARIO)/COUNT(CPF) FROM FUNCIONARIO GROUP BY DNR;
+------+------------+--------------+--------------+--------------+-------------------------+
| DNR  | COUNT(CPF) | AVG(SALARIO) | MIN(SALARIO) | MAX(SALARIO) | SUM(SALARIO)/COUNT(CPF) |
+------+------------+--------------+--------------+--------------+-------------------------+
|    1 |          1 |        55000 | 55000        | 55000        |                   55000 |
|    4 |          3 |        31000 | 25000        | 43000        |                   31000 |
|    5 |          4 |        33250 | 25000        | 40000        |                   33250 |
+------+------------+--------------+--------------+--------------+-------------------------+

-- CONTANDO O TOTAL DE CPF, A MÉDIA DOS SALÁRIOS, MENOR SALÁRIO, MENOR SALÁRIO, CÁLCULO DA MÉDIA DOS SALÁRIO (MANEIRA DIFERENTE) E MEDIANA DOS SALÁRIOS AGRUPADOS POR DEPARTAMENTO
SELECT DNR, COUNT(CPF), AVG(SALARIO), MIN(SALARIO), MAX(SALARIO), SUM(SALARIO)/COUNT(CPF), (MAX(SALARIO) - MIN(SALARIO)/2) FROM FUNCIONARIO GROUP BY DNR;
+------+------------+--------------+--------------+--------------+-------------------------+---------------------------------+
| DNR  | COUNT(CPF) | AVG(SALARIO) | MIN(SALARIO) | MAX(SALARIO) | SUM(SALARIO)/COUNT(CPF) | (MAX(SALARIO) - MIN(SALARIO)/2) |
+------+------------+--------------+--------------+--------------+-------------------------+---------------------------------+
|    1 |          1 |        55000 | 55000        | 55000        |                   55000 |                           27500 |
|    4 |          3 |        31000 | 25000        | 43000        |                   31000 |                           30500 |
|    5 |          4 |        33250 | 25000        | 40000        |                   33250 |                           27500 |
+------+------------+--------------+--------------+--------------+-------------------------+---------------------------------+

-- OPERAÇÃO DE FECHAMENTO RECURSIVO
SELECT * FROM FUNCIONARIO F WHERE F.CPF_SUPERVISOR = '88866555576'
UNION 
SELECT F1.*
	FROM FUNCIONARIO F1,
		 FUNCIONARIO F2
	WHERE F1.CPF_SUPERVISOR = F2.CPF
		AND F2.CPF_SUPERVISOR = '88866555576';
+----------+----------+---------+-------------+--------------------+------------+------+---------+----------------+------+
| PNOME    | MINICIAL | UNOME   | CPF         | ENDERECO           | DATANASC   | SEXO | SALARIO | CPF_SUPERVISOR | DNR  |
+----------+----------+---------+-------------+--------------------+------------+------+---------+----------------+------+
| FERNANDO | T        | WONG    | 33344555587 | RUA DA LAPA        | 08-12-1955 | M    | 40000   | 88866555576    |    5 |
| JENIFER  | F        | SOUZA   | 98765432168 | AV. ARTHUR DE LIMA | 20-06-1941 | F    | 43000   | 88866555576    |    4 |
| JOÃO     | B        | SILVA   | 12345678966 | RUA DAS FLORES     | 09-01-1965 | M    | 30000   | 33344555587    |    5 |
| JOICE    | A        | LEITE   | 45345345376 | AV. LUCAS OBEC     | 31-07-1972 | F    | 25000   | 33344555587    |    5 |
| RONALLDO | K        | LIMA    | 66688444476 | RUA REBOUÇAS       | 15-09-1962 | M    | 38000   | 33344555587    |    5 |
| ANDRÉ    | V        | PEREIRA | 98798798733 | RUA TIMBIRA        | 29-03-1969 | M    | 25000   | 98765432168    |    4 |
| ALICE    | J        | ZELAYA  | 99988777767 | RUA SOUZA LIMA     | 19-01-1968 | F    | 25000   | 98765432168    |    4 |
+----------+----------+---------+-------------+--------------------+------------+------+---------+----------------+------+
		
-- OPERAÇÃO DE JUNÇÃO EXTERNA
SELECT 
    F1.PNOME AS NOME_FUNCIONARIO,
	F2.PNOME AS NOME_SUPERVISOR
FROM 
    FUNCIONARIO F1
LEFT JOIN 
    FUNCIONARIO F2 ON F1.CPF_SUPERVISOR = F2.CPF;
+------------------+-----------------+
| NOME_FUNCIONARIO | NOME_SUPERVISOR |
+------------------+-----------------+
| JOÃO             | FERNANDO        |
| FERNANDO         | JORGE           |
| JOICE            | FERNANDO        |
| RONALLDO         | FERNANDO        |
| JORGE            | NULL            |
| JENIFER          | JORGE           |
| ANDRÉ            | JENIFER         |
| ALICE            | JENIFER         |
+------------------+-----------------+