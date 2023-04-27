--1번--0
select 사원명,급여
from sawon_test
where 1=1
and 급여 >=8000000

--2번--0
select 사원명, 부서코드, 급여, 입사일
from sawon_test
where 1=1
and 입사일 between '2010-01-01' and '2018-12-31'

--3번--O
select A.사원명, 
       A.근무지코드, 
       A.부서코드
from sawon_test A
where 입사일 >= '2018-08-01'
AND 입사일 <= '2018-08-31'
AND 부서코드 != 'C'


--4번--O
SELECT COUNT(*)
FROM sawon_test

--5번--O
SELECT COUNT(*), SUM(급여) 
FROM sawon_test A
WHERE 1=1
AND 상급자사원번호 IS null

--6번--O
SELECT COUNT(*), SUM(급여)
FROM sawon_test 
WHERE 1=1
AND 급여 <= 3000000
AND 입사일 >= '2020-08-15'


--7번--0
SELECT *
FROM sawon_test
WHERE 사원명 LIKE '한%'

--8번--X
SELECT A.*,(
    SELECT 직급코드
    FROM SAWON_TEST
    GROUP BY 직급코드
    )B
FROM SAWON_TEST A


--9번--O
SELECT SUM(급여)
FROM SAWON_TEST
WHERE 1=1
AND 사원명 LIKE '%삭%'
OR 사원명 LIKE '김%'

--10번--O
SELECT 부서코드,COUNT(*) AS COUNT_BUSEO
FROM SAWON_TEST
GROUP BY 부서코드

--11번--O
SELECT 근무지코드, COUNT(*) AS REGION_COUNT
FROM SAWON_TEST
GROUP BY 근무지코드

--12번--O
SELECT MAX(급여), MIN(급여)
FROM SAWON_TEST

--13번--O
SELECT AVG(급여), MAX(급여)
FROM SAWON_TEST
WHERE 1=1
AND 급여 >= 5000000
AND 급여 <= 8000000

--14번--O
SELECT MAX(급여),MIN(급여), MAX(급여)-MIN(급여)
FROM SAWON_TEST

--15번--O
SELECT COUNT(부서코드)
FROM(
    SELECT *
    FROM SAWON_TEST 
    WHERE 1=1
    AND 근무지코드 != 'A1'
)
GROUP BY 부서코드

--16번--X
SELECT 부서코드, 사원번호, 사원명
FROM(
    SELECT 부서코드 
    FROM SAWON_TEST 
    GROUP BY 부서코드
)
WHERE 1=1
ORDER BY 사원번호 ASC

--17번--O
SELECT 사원명, 부서코드
FROM SAWON_TEST
GROUP BY 사원명, 부서코드

--18번--O
SELECT A.사원명, 
       A.부서코드,
       CASE WHEN A.부서코드 IS NULL THEN '부서명없음' ELSE A.부서코드 END
FROM SAWON_TEST A
GROUP BY 사원명, 부서코드

--19번--O
SELECT 부서코드, 사원명, 입사일
FROM SAWON_TEST
ORDER BY 부서코드 ASC, 사원명 ASC, 입사일 ASC

--20번--X
SELECT COUNT(BE_VALUE)
FROM(
    SELECT 부서코드, 사원명
    FROM SAWON_TEST
    GROUP BY 부서코드, 사원명
)AS BE_VALUE

SELECT *
FROM 부서

--21번--O
SELECT 사원명,
      CASE WHEN 급여 < 1000000 THEN 0
            WHEN 급여 <= 1000000 AND 급여 > 2000000 THEN 200
            WHEN 급여 <= 2000000 AND 급여 > 3000000 THEN 300
            WHEN 급여 <= 3000000 AND 급여 > 4000000 THEN 400
            WHEN 급여 <= 4000000 AND 급여 > 5000000 THEN 500
            WHEN 급여 <= 6000000 AND 급여 > 7000000 THEN 600
            WHEN 급여 <= 7000000 AND 급여 > 8000000 THEN 700
            WHEN 급여 <= 8000000 AND 급여 > 9000000 THEN 800
            ELSE 900
            END AS 급여구간
FROM SAWON_TEST A

--22번--X
SELECT SUM(B.급여) AS SUM_급여
    FROM(
        SELECT 부서코드,급여
        FROM SAWON_TEST A
        GROUP BY 부서코드,급여
    )B
WHERE 1=1
AND B.부서코드 = A.부서코드

--23번--0
SELECT 부서코드, MIN(급여) AS MIN_급여, MAX(급여)AS MAX_급여
FROM SAWON_TEST
GROUP BY 부서코드

--24번--0

SELECT *
FROM SAWON_TEST 

SELECT 사원번호,사원명,상급자사원번호,
    (SELECT 사원명    
    FROM SAWON_TEST B
    WHERE A.상급자사원번호 = B.사원번호)AS 상급자명
FROM SAWON_TEST A

--25번--X
SELECT 
(   SELECT 사원번호, 사원명, 부서코드
    FROM SAWON_TEST B
    WHERE 1=1
    AND A.상급자사원번호 = B.사원번호
)
FROM SAWON_TEST A

--26번--X

SELECT *
FROM SAWON_TEST

SELECT *
FROM(
    SELECT 부서코드,SUM(급여) AS SUM_급여
    FROM(
        SELECT 부서코드, 급여
        FROM SAWON_TEST
        GROUP BY 부서코드, 급여
        )
    GROUP BY 부서코드
)
WHERE SUM_급여 <= 100000000

--27번--O
SELECT A.*
FROM SAWON_TEST A
WHERE A.부서코드 IN ( SELECT 
                      CASE WHEN 부서코드 IS NULL THEN '부서명없음' ELSE 부서코드 END AS 부서코드
                   FROM SAWON_TEST B
                   GROUP BY 부서코드
                   HAVING COUNT(*) < 2
                   )
                   
--28번--0

SELECT 
    CASE WHEN 부서코드 IS NULL THEN '부서명없음' ELSE 부서코드 END AS 부서코드,
    COUNT(부서코드) AS 사원수
FROM SAWON_TEST 
GROUP BY 부서코드

--29번--X

SELECT MAX(COUNT_사원수) AS MAX_사원수
FROM(
    SELECT 상급자명, COUNT(상급자명) AS COUNT_사원수

    FROM(
        SELECT (SELECT 사원명    
            FROM SAWON_TEST B
            WHERE A.상급자사원번호 = B.사원번호)AS 상급자명
        FROM SAWON_TEST A
    )
    GROUP BY 상급자명
)

--30번-- X
SELECT *
FROM SAWON_TEST

--31번--

    SELECT 사원명
    FROM SAWON_TEST 
    WHERE (
        SELECT 직급코드, MIN(급여) AS 최소금액
        FROM SAWON_TEST A
        GROUP BY 직급코드
        )

--32번--X

--33번--X

--17번--0
SELECT A.*,B.부서명
FROM SAWON_TEST A
LEFT JOIN 부서 B
ON A.부서코드 = B.부서코드

--18번--O
SELECT A.사원명,
       CASE WHEN 부서명 IS NULL THEN '부서명없음' ELSE  B.부서명 END AS 부서명   
FROM SAWON_TEST A
LEFT JOIN 부서 B
ON A.부서코드 = B.부서코드

--19번--O
SELECT *
FROM (
    SELECT B.부서명, A.사원명, A.입사일 
    FROM SAWON_TEST A
    LEFT JOIN 부서 B
    ON A.부서코드 = B.부서코드
    )
ORDER BY 부서명 ASC

--20번--O
SELECT 부서명,COUNT(*) AS COUNT_AS
FROM(
    SELECT A.사원명,
           CASE WHEN 부서명 IS NULL THEN '부서명없음' ELSE B.부서명 END AS 부서명
    FROM SAWON_TEST A
    LEFT JOIN 부서 B
    ON A.부서코드 = B.부서코드
)
GROUP BY 부서명

--21번--0
SELECT *
FROM SAWON_TEST

SELECT *
FROM 부서


--22번-- O

SELECT  부서명,
        SUM(급여) AS SUM_급여
FROM(
    SELECT C.*, D.부서명
    FROM(
        SELECT A.*, B.직급명
        FROM SAWON_TEST A
        LEFT JOIN 직급 B
        ON A.직급코드 = B.직급코드
        WHERE 1=1
        AND 직급명 = '사원'
        )C
    LEFT JOIN 부서 D
    ON C.부서코드= D.부서코드
    )
GROUP BY 부서명

--23번--O
SELECT 부서명, MAX(급여) AS MAX_급여, MIN(급여) AS MIN_급여
FROM(
    SELECT A.*, B.부서명
    FROM SAWON_TEST A
    LEFT JOIN 부서 B
    ON A.부서코드 = B.부서코드
    )
GROUP BY 부서명

--25번--0

SELECT *
FROM SAWON_TEST

SELECT 상급자명, AVG(급여) AS AVG_급여
FROM(
    SELECT 사원번호, 사원명, 상급자사원번호, 급여,
        (SELECT 사원명
        FROM SAWON_TEST B
        WHERE A.상급자사원번호 = B.사원번호)AS 상급자명
    FROM SAWON_TEST A
    )
GROUP BY 상급자명

--26번--O
SELECT *
FROM(
    SELECT 부서명, SUM(급여) AS SUM_급여
    FROM(
        SELECT A.*, 부서명
        FROM SAWON_TEST A
        LEFT JOIN 부서 B
        ON A.부서코드 = B.부서코드
    )
    GROUP BY 부서명
    )
WHERE SUM_급여 >= 100000000

--27번-- 0

SELECT * 
FROM SAWON_TEST

SELECT *
FROM 부서

SELECT *
FROM(
    SELECT CASE WHEN 부서명 IS NULL THEN '부서명없음' ELSE 부서명 END AS 부서명, 
           COUNT(부서명) AS COUNT_부서명   
    FROM(
        SELECT A.*, B.부서명
        FROM SAWON_TEST A
        LEFT JOIN 부서 B
        ON A.부서코드 = B.부서코드
        )
    GROUP BY 부서명
    )
WHERE COUNT_부서명 < 2

--28번--O
    SELECT CASE WHEN 부서명 IS NULL THEN '부서명없음' ELSE 부서명 END AS 부서명,
           COUNT(부서명) AS COUNT_부서명
    FROM(
        SELECT A.*,B.부서명
        FROM SAWON_TEST A
        LEFT JOIN 부서 B
        ON A.부서코드 = B.부서코드
        )
    GROUP BY 부서명 


SELECT E.새로운부서명 AS 부서명, E.새로운사원수 AS 사원수
FROM(
    SELECT D.*,
           CASE WHEN D.부서명 IS NULL THEN 0
           ELSE D.사원수
           END AS 새로운사원수
    FROM
    (
        SELECT C.*,
               CASE WHEN C.부서명 IS NULL THEN '부서명없음'
               ELSE C.부서명
               END AS 새로운부서명
        FROM(
            SELECT A.부서코드,
                   B.부서명,
                   A.사원수
            FROM(
                SELECT 부서코드,
                       COUNT(사원명) AS 사원수
                FROM SAWON_TEST
                GROUP BY 부서코드
            )A
            LEFT JOIN BUSEO_TEST B
            ON A.부서코드 = B.부서코드
        )C
    )D
)E

--29번--X
SELECT *
FROM SAWON_TEST

SELECT C.*,부서명
FROM(
    SELECT B.*
       (SELECT 사원명
        FROM SAWON_TEST A
        WHERE 1=1
        AND A.사원번호 = B.상급자사원번호)AS 상급자명
    FROM SAWON_TEST B
    )C
LEFT JOIN 부서 D
ON D.부서코드 = C.부서코드

--30번--

SELECT *
FROM SAWON_TEST

SELECT *
FROM 부서

SELECT *
FROM 직급

SELECT *
FROM 근무지

SELECT *
FROM 사원

SELECT  
FROM(
    SELECT *
    
    FROM SAWON_TEST A
    LEFT JOIN 부서 B
    ON A.부서코드 = B.부서코드
)C
WHERE 1=1 
AND 직급코드 = 10
