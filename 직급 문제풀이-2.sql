--1��--0
select �����,�޿�
from sawon_test
where 1=1
and �޿� >=8000000

--2��--0
select �����, �μ��ڵ�, �޿�, �Ի���
from sawon_test
where 1=1
and �Ի��� between '2010-01-01' and '2018-12-31'

--3��--O
select A.�����, 
       A.�ٹ����ڵ�, 
       A.�μ��ڵ�
from sawon_test A
where �Ի��� >= '2018-08-01'
AND �Ի��� <= '2018-08-31'
AND �μ��ڵ� != 'C'


--4��--O
SELECT COUNT(*)
FROM sawon_test

--5��--O
SELECT COUNT(*), SUM(�޿�) 
FROM sawon_test A
WHERE 1=1
AND ����ڻ����ȣ IS null

--6��--O
SELECT COUNT(*), SUM(�޿�)
FROM sawon_test 
WHERE 1=1
AND �޿� <= 3000000
AND �Ի��� >= '2020-08-15'


--7��--0
SELECT *
FROM sawon_test
WHERE ����� LIKE '��%'

--8��--X
SELECT A.*,(
    SELECT �����ڵ�
    FROM SAWON_TEST
    GROUP BY �����ڵ�
    )B
FROM SAWON_TEST A


--9��--O
SELECT SUM(�޿�)
FROM SAWON_TEST
WHERE 1=1
AND ����� LIKE '%��%'
OR ����� LIKE '��%'

--10��--O
SELECT �μ��ڵ�,COUNT(*) AS COUNT_BUSEO
FROM SAWON_TEST
GROUP BY �μ��ڵ�

--11��--O
SELECT �ٹ����ڵ�, COUNT(*) AS REGION_COUNT
FROM SAWON_TEST
GROUP BY �ٹ����ڵ�

--12��--O
SELECT MAX(�޿�), MIN(�޿�)
FROM SAWON_TEST

--13��--O
SELECT AVG(�޿�), MAX(�޿�)
FROM SAWON_TEST
WHERE 1=1
AND �޿� >= 5000000
AND �޿� <= 8000000

--14��--O
SELECT MAX(�޿�),MIN(�޿�), MAX(�޿�)-MIN(�޿�)
FROM SAWON_TEST

--15��--O
SELECT COUNT(�μ��ڵ�)
FROM(
    SELECT *
    FROM SAWON_TEST 
    WHERE 1=1
    AND �ٹ����ڵ� != 'A1'
)
GROUP BY �μ��ڵ�

--16��--X
SELECT �μ��ڵ�, �����ȣ, �����
FROM(
    SELECT �μ��ڵ� 
    FROM SAWON_TEST 
    GROUP BY �μ��ڵ�
)
WHERE 1=1
ORDER BY �����ȣ ASC

--17��--O
SELECT �����, �μ��ڵ�
FROM SAWON_TEST
GROUP BY �����, �μ��ڵ�

--18��--O
SELECT A.�����, 
       A.�μ��ڵ�,
       CASE WHEN A.�μ��ڵ� IS NULL THEN '�μ������' ELSE A.�μ��ڵ� END
FROM SAWON_TEST A
GROUP BY �����, �μ��ڵ�

--19��--O
SELECT �μ��ڵ�, �����, �Ի���
FROM SAWON_TEST
ORDER BY �μ��ڵ� ASC, ����� ASC, �Ի��� ASC

--20��--X
SELECT COUNT(BE_VALUE)
FROM(
    SELECT �μ��ڵ�, �����
    FROM SAWON_TEST
    GROUP BY �μ��ڵ�, �����
)AS BE_VALUE

SELECT *
FROM �μ�

--21��--O
SELECT �����,
      CASE WHEN �޿� < 1000000 THEN 0
            WHEN �޿� <= 1000000 AND �޿� > 2000000 THEN 200
            WHEN �޿� <= 2000000 AND �޿� > 3000000 THEN 300
            WHEN �޿� <= 3000000 AND �޿� > 4000000 THEN 400
            WHEN �޿� <= 4000000 AND �޿� > 5000000 THEN 500
            WHEN �޿� <= 6000000 AND �޿� > 7000000 THEN 600
            WHEN �޿� <= 7000000 AND �޿� > 8000000 THEN 700
            WHEN �޿� <= 8000000 AND �޿� > 9000000 THEN 800
            ELSE 900
            END AS �޿�����
FROM SAWON_TEST A

--22��--X
SELECT SUM(B.�޿�) AS SUM_�޿�
    FROM(
        SELECT �μ��ڵ�,�޿�
        FROM SAWON_TEST A
        GROUP BY �μ��ڵ�,�޿�
    )B
WHERE 1=1
AND B.�μ��ڵ� = A.�μ��ڵ�

--23��--0
SELECT �μ��ڵ�, MIN(�޿�) AS MIN_�޿�, MAX(�޿�)AS MAX_�޿�
FROM SAWON_TEST
GROUP BY �μ��ڵ�

--24��--0

SELECT *
FROM SAWON_TEST 

SELECT �����ȣ,�����,����ڻ����ȣ,
    (SELECT �����    
    FROM SAWON_TEST B
    WHERE A.����ڻ����ȣ = B.�����ȣ)AS ����ڸ�
FROM SAWON_TEST A

--25��--X
SELECT 
(   SELECT �����ȣ, �����, �μ��ڵ�
    FROM SAWON_TEST B
    WHERE 1=1
    AND A.����ڻ����ȣ = B.�����ȣ
)
FROM SAWON_TEST A

--26��--X

SELECT *
FROM SAWON_TEST

SELECT *
FROM(
    SELECT �μ��ڵ�,SUM(�޿�) AS SUM_�޿�
    FROM(
        SELECT �μ��ڵ�, �޿�
        FROM SAWON_TEST
        GROUP BY �μ��ڵ�, �޿�
        )
    GROUP BY �μ��ڵ�
)
WHERE SUM_�޿� <= 100000000

--27��--O
SELECT A.*
FROM SAWON_TEST A
WHERE A.�μ��ڵ� IN ( SELECT 
                      CASE WHEN �μ��ڵ� IS NULL THEN '�μ������' ELSE �μ��ڵ� END AS �μ��ڵ�
                   FROM SAWON_TEST B
                   GROUP BY �μ��ڵ�
                   HAVING COUNT(*) < 2
                   )
                   
--28��--0

SELECT 
    CASE WHEN �μ��ڵ� IS NULL THEN '�μ������' ELSE �μ��ڵ� END AS �μ��ڵ�,
    COUNT(�μ��ڵ�) AS �����
FROM SAWON_TEST 
GROUP BY �μ��ڵ�

--29��--X

SELECT MAX(COUNT_�����) AS MAX_�����
FROM(
    SELECT ����ڸ�, COUNT(����ڸ�) AS COUNT_�����

    FROM(
        SELECT (SELECT �����    
            FROM SAWON_TEST B
            WHERE A.����ڻ����ȣ = B.�����ȣ)AS ����ڸ�
        FROM SAWON_TEST A
    )
    GROUP BY ����ڸ�
)

--30��-- X
SELECT *
FROM SAWON_TEST

--31��--

    SELECT �����
    FROM SAWON_TEST 
    WHERE (
        SELECT �����ڵ�, MIN(�޿�) AS �ּұݾ�
        FROM SAWON_TEST A
        GROUP BY �����ڵ�
        )

--32��--X

--33��--X

--17��--0
SELECT A.*,B.�μ���
FROM SAWON_TEST A
LEFT JOIN �μ� B
ON A.�μ��ڵ� = B.�μ��ڵ�

--18��--O
SELECT A.�����,
       CASE WHEN �μ��� IS NULL THEN '�μ������' ELSE  B.�μ��� END AS �μ���   
FROM SAWON_TEST A
LEFT JOIN �μ� B
ON A.�μ��ڵ� = B.�μ��ڵ�

--19��--O
SELECT *
FROM (
    SELECT B.�μ���, A.�����, A.�Ի��� 
    FROM SAWON_TEST A
    LEFT JOIN �μ� B
    ON A.�μ��ڵ� = B.�μ��ڵ�
    )
ORDER BY �μ��� ASC

--20��--O
SELECT �μ���,COUNT(*) AS COUNT_AS
FROM(
    SELECT A.�����,
           CASE WHEN �μ��� IS NULL THEN '�μ������' ELSE B.�μ��� END AS �μ���
    FROM SAWON_TEST A
    LEFT JOIN �μ� B
    ON A.�μ��ڵ� = B.�μ��ڵ�
)
GROUP BY �μ���

--21��--0
SELECT *
FROM SAWON_TEST

SELECT *
FROM �μ�


--22��-- O

SELECT  �μ���,
        SUM(�޿�) AS SUM_�޿�
FROM(
    SELECT C.*, D.�μ���
    FROM(
        SELECT A.*, B.���޸�
        FROM SAWON_TEST A
        LEFT JOIN ���� B
        ON A.�����ڵ� = B.�����ڵ�
        WHERE 1=1
        AND ���޸� = '���'
        )C
    LEFT JOIN �μ� D
    ON C.�μ��ڵ�= D.�μ��ڵ�
    )
GROUP BY �μ���

--23��--O
SELECT �μ���, MAX(�޿�) AS MAX_�޿�, MIN(�޿�) AS MIN_�޿�
FROM(
    SELECT A.*, B.�μ���
    FROM SAWON_TEST A
    LEFT JOIN �μ� B
    ON A.�μ��ڵ� = B.�μ��ڵ�
    )
GROUP BY �μ���

--25��--0

SELECT *
FROM SAWON_TEST

SELECT ����ڸ�, AVG(�޿�) AS AVG_�޿�
FROM(
    SELECT �����ȣ, �����, ����ڻ����ȣ, �޿�,
        (SELECT �����
        FROM SAWON_TEST B
        WHERE A.����ڻ����ȣ = B.�����ȣ)AS ����ڸ�
    FROM SAWON_TEST A
    )
GROUP BY ����ڸ�

--26��--O
SELECT *
FROM(
    SELECT �μ���, SUM(�޿�) AS SUM_�޿�
    FROM(
        SELECT A.*, �μ���
        FROM SAWON_TEST A
        LEFT JOIN �μ� B
        ON A.�μ��ڵ� = B.�μ��ڵ�
    )
    GROUP BY �μ���
    )
WHERE SUM_�޿� >= 100000000

--27��-- 0

SELECT * 
FROM SAWON_TEST

SELECT *
FROM �μ�

SELECT *
FROM(
    SELECT CASE WHEN �μ��� IS NULL THEN '�μ������' ELSE �μ��� END AS �μ���, 
           COUNT(�μ���) AS COUNT_�μ���   
    FROM(
        SELECT A.*, B.�μ���
        FROM SAWON_TEST A
        LEFT JOIN �μ� B
        ON A.�μ��ڵ� = B.�μ��ڵ�
        )
    GROUP BY �μ���
    )
WHERE COUNT_�μ��� < 2

--28��--O
    SELECT CASE WHEN �μ��� IS NULL THEN '�μ������' ELSE �μ��� END AS �μ���,
           COUNT(�μ���) AS COUNT_�μ���
    FROM(
        SELECT A.*,B.�μ���
        FROM SAWON_TEST A
        LEFT JOIN �μ� B
        ON A.�μ��ڵ� = B.�μ��ڵ�
        )
    GROUP BY �μ��� 


SELECT E.���ο�μ��� AS �μ���, E.���ο����� AS �����
FROM(
    SELECT D.*,
           CASE WHEN D.�μ��� IS NULL THEN 0
           ELSE D.�����
           END AS ���ο�����
    FROM
    (
        SELECT C.*,
               CASE WHEN C.�μ��� IS NULL THEN '�μ������'
               ELSE C.�μ���
               END AS ���ο�μ���
        FROM(
            SELECT A.�μ��ڵ�,
                   B.�μ���,
                   A.�����
            FROM(
                SELECT �μ��ڵ�,
                       COUNT(�����) AS �����
                FROM SAWON_TEST
                GROUP BY �μ��ڵ�
            )A
            LEFT JOIN BUSEO_TEST B
            ON A.�μ��ڵ� = B.�μ��ڵ�
        )C
    )D
)E

--29��--X
SELECT *
FROM SAWON_TEST

SELECT C.*,�μ���
FROM(
    SELECT B.*
       (SELECT �����
        FROM SAWON_TEST A
        WHERE 1=1
        AND A.�����ȣ = B.����ڻ����ȣ)AS ����ڸ�
    FROM SAWON_TEST B
    )C
LEFT JOIN �μ� D
ON D.�μ��ڵ� = C.�μ��ڵ�

--30��--

SELECT *
FROM SAWON_TEST

SELECT *
FROM �μ�

SELECT *
FROM ����

SELECT *
FROM �ٹ���

SELECT *
FROM ���

SELECT  
FROM(
    SELECT *
    
    FROM SAWON_TEST A
    LEFT JOIN �μ� B
    ON A.�μ��ڵ� = B.�μ��ڵ�
)C
WHERE 1=1 
AND �����ڵ� = 10
