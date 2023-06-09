select *
from kopo_channel_seasonality_new

SELECT SUM(QTY)
FROM KOPO_CHANNEL_SEASONALITY_NEW

SELECT SUM(QTY) AS SUM_QTY,
       MAX(YEARWEEK) AS MAX_YEARWEEK,
       MIN(YEARWEEK) AS MIN_YEARWEEK,
       COUNT(QTY) AS QTY_COUNT
FROM KOPO_CHANNEL_SEASONALITY_NEW

SELECT COUNT(*)
FROM KOPO_CHANNEL_SEASONALITY_NEW

SELECT REGIONID,PRODUCT,
        SUM(QTY) AS SUM_QTY,
        MAX(QTY) AS MAX_QTY,
        MIN(QTY) AS MIN_QTY,
        AVG(QTY) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID,PRODUCT
ORDER BY MAX_QTY DESC  --ASC

SELECT *
FROM KOPO_CHANNEL_RESULT

SELECT YEARWEEK,QTY,
        SUM(QTY) AS SUM_QTY,
        MIN(QTY) AS MIN_QTY,
        MAX(QTY) AS MAX_QTY,
        AVG(QTY) AS AVG_QTY
FROM KOPO_CHANNEL_RESULT
GROUP BY YEARWEEK, QTY
ORDER BY YEARWEEK  

SELECT ACCOUNTNAME,COUNT(QTY) AS ACCOUNT_COUNT
FROM KOPO_CHANNEL_RESULT
WHERE AP2ID IN ('A01','A02','A03','A04')
GROUP BY ACCOUNTNAME
HAVING SUM(QTY) > 10000

--위아래 같은 표현임

SELECT *
FROM(
    SELECT ACCOUNTNAME,COUNT(QTY) AS ACCOUNT_COUNT
    FROM KOPO_CHANNEL_RESULT
    WHERE AP2ID IN ('A01','A02','A03','A04')
    GROUP BY ACCOUNTNAME
)
WHERE ACCOUNT_COUNT > 10000

SELECT *
FROM(
    SELECT ACCOUNTNAME,
        'KOPO_'|| ACCOUNTNAME AS NEW_ACCOUNT,
        COUNT(QTY) AS ACOOUNT_COUNT
    FROM KOPO_CHANNEL_RESULT
    WHERE AP2ID IN('A01', 'A02', 'A03', 'A04')
    GROUP BY ACCOUNTNAME
)
WHERE 1=1
AND NEW_ACCOUNT LIKE '%KOPO%'


--SELECT ACCOUNTNAME,
--        'KOPO_' || ACCOUNTNAME AS NEW_ACCOUNT,
--        COUNT(QTY) AS ACCOUNT_COUNT
--FROM KOPO_CHANNEL_RESULT
--WHERE AP2ID IN('A01', 'A02', 'A03', 'A04')
--AND NEW_ACCOUNT LIKE '%KOPO'
--GROUP BY ACCOUNTNAME        
 -- 오류나는 구문, NEW_ACCOUNT라는 컬럼을 만들면서 AND조건으로 바로 조회할 수 없다. 
 -- 따라서 NEW_ACCOUNT라는 컬럼을 먼저 만들고, 이를 서브쿼리를 활용해서 조건절로 조회하여야한다! 

SELECT *
FROM KOPO_PRODUCT_VOLUME

SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
--AND REGIONID IN('A01','A02')
AND REGIONID IN (SELECT DISTINCT REGIONID    --DISTINCT가 들어가면 중복제거가 되어 'A01','A02'만 나옴
                 FROM KOPO_PRODUCT_VOLUME)

                         
CREATE TABLE REGION_MST_MS(
    REGIONID VARCHAR(200)
    )
     
SELECT *
FROM REGION_MST_MS

INSERT INTO REGION_MST_MS
VALUES('KOPO_A60')

SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW


SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND 'KOPO_'||REGIONID IN(SELECT REGIONID
                         FROM REGION_MST_MS
                         ) --왜 안돼!!!
     
 ------------------------------------0424---------------------------------------------------복습완료                  
SELECT A. REGIONID,
       A. PRODUCT,
       A. YEARWEEK,
       A. QTY,
       ( SELECT AVG(B.QTY)
         FROM KOPO_CHANNEL_SEASONALITY_NEW B
         WHERE 1=1
         AND B.REGIONID = A.REGIONID
         AND B.PRODUCT = A.PRODUCT
         ) AS AVG_QTY
         --(SELECT C.REGIONID
         --FROM KOPO_CHANNEL_SEASONALITY_NEW C) AS NEW_COLUMN2
FROM KOPO_CHANNEL_SEASONALITY_NEW A

-- STEP 1. 지역, 상품별 평균 판매량을 구한다.
-- STEP 2. 기존 실적데이터와 조인키(지역,상품)키로 데이터를 조인한다.

SELECT A.*, B.AVG_QTY
FROM 
 A
LEFT JOIN(
            SELECT REGIONID,
                   PRODUCT,
                   AVG(QTY) AS AVG_QTY
            FROM KOPO_CHANNEL_SEASONALITY_NEW
            GROUP BY REGIONID, PRODUCT
            )B
ON A.REGIONID = B.REGIONID
AND A.PRODUCT = B.PRODUCT

SELECT A.*
FROM KOPO_CHANNEL_SEASONALITY_NEW A

SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW

SELECT REGIONID,PRODUCT,QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE REGIONID = 'A60'
AND PRODUCT = 'PRODUCT4'


SELECT A. REGIONID,
       A. PRODUCT,
       A. YEARWEEK,
       A. QTY,
       ( SELECT AVG(B.QTY)
         FROM KOPO_CHANNEL_SEASONALITY_NEW B
         WHERE 1=1
         AND B.REGIONID = 'A60'
         AND B.PRODUCT = 'PRODUCT4'
         ) AS AVG_QTY
         --(SELECT C.REGIONID
         --FROM KOPO_CHANNEL_SEASONALITY_NEW C) AS NEW_COLUMN2
FROM KOPO_CHANNEL_SEASONALITY_NEW A
--A60과 PRODUCT4의 평균값이 모든 AVG_QTY에 다 들어간다.


WITH A AS
(   SELECT *
    FROM KOPO_CHANNEL_RESULT 
    WHERE 1=1
    AND AP2ID IN ('A01','A02')
)
SELECT *
FROM A;

SELECT *
FROM ( SELECT *
       FROM KOPO_CHANNEL_RESULT
       WHERE 1=1
       AND AP2ID IN ('A01','A02')
)


--INNER 124332
--LEFT 124646
--RIGHT 124337
--FULL OUTER JOIN 124651


SELECT COUNT(*)
FROM(
    SELECT A.*, B.*
    FROM KOPO_CHANNEL_SEASONALITY_NEW A -- A77법인이 있다
    RIGHT JOIN KOPO_REGION_MST B -- A77 법인이 없다
    ON A.REGIONID = B.REGIONID
    WHERE 1=1
    -- 124646
)

SELECT DISTINCT A.REGIONID
FROM KOPO_REGION_MST A
WHERE 1=1
AND A.REGIONID NOT IN (SELECT REGIONID 
                       FROM KOPO_CHANNEL_SEASONALITY_NEW)
                       
SELECT DISTINCT A.REGIONID
FROM KOPO_CHANNEL_SEASONALITY_NEW A
WHERE 1=1
AND A.REGIONID NOT IN (SELECT REGIONID 
                       FROM KOPO_REGION_MST)