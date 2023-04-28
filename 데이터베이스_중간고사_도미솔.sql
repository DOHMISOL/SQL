
CREATE TABLE KOPO_MIDDLE_2023_도미솔1 AS
SELECT PRD_SEG1, PRD_SEG2, PRD_SEG3, YEAR, WEEK, QTY, FCST_W6, FCST_W5, FCST_W4, FCST_W3,FCST_W2,FCST_W1
FROM(
    SELECT J.*, I.OUTFCST AS FCST_W1
    FROM(
        SELECT H.*,G.OUTFCST AS FCST_W2
        FROM(      
            SELECT F.*, E.OUTFCST AS FCST_W3
            FROM(
                SELECT D.*, C. OUTFCST AS FCST_W4
                FROM(
                        SELECT A.*, B.OUTFCST AS FCST_W5
                        FROM (
                            SELECT PRD_SEG1,PRD_SEG2, PRD_SEG3, YEAR, WEEK, QTY, OUTFCST AS FCST_W6 
                            FROM KOPO_FINAL_6WEEK
                            WHERE WEEK = 18
                            )A 
                        LEFT JOIN  KOPO_FINAL_5WEEK B
                        ON B.PRD_SEG1 = A.PRD_SEG1
                        AND B.PRD_SEG2 = A.PRD_SEG2
                        AND B.PRD_SEG3 = A.PRD_SEG3
                        AND B.YEAR = A.YEAR
                        AND B.WEEK = A.WEEK
                        AND B.QTY = A.QTY
                )D
                LEFT JOIN KOPO_FINAL_4WEEK C
                ON C.PRD_SEG1 = D.PRD_SEG1
                AND C.PRD_SEG2 = D.PRD_SEG2
                AND C.PRD_SEG3 = D.PRD_SEG3
                AND C.YEAR = D.YEAR
                AND C.WEEK = D.WEEK
                AND C.QTY = D.QTY
            )F
            LEFT JOIN KOPO_FINAL_3WEEK E
            ON E.PRD_SEG1 = F.PRD_SEG1
            AND E.PRD_SEG2 = F.PRD_SEG2
            AND E.PRD_SEG3 = F.PRD_SEG3
            AND E.YEAR = F.YEAR
            AND E.WEEK = F.WEEK
            AND E.QTY = F.QTY
        )H
        LEFT JOIN KOPO_FINAL_2WEEK G
        ON G.PRD_SEG1 = H.PRD_SEG1
        AND G.PRD_SEG2 = H.PRD_SEG2
        AND G.PRD_SEG3 = H.PRD_SEG3
        AND G.YEAR = H.YEAR
        AND G.WEEK = H.WEEK
        AND G.QTY = H.QTY
    )J
    LEFT JOIN KOPO_FINAL_1WEEK I
    ON I.PRD_SEG1 = J.PRD_SEG1
    AND I.PRD_SEG2 = J.PRD_SEG2
    AND I.PRD_SEG3 = J.PRD_SEG3
    AND I.YEAR = J.YEAR
    AND I.WEEK = J.WEEK
    AND I.QTY = J.QTY
)

SELECT *
FROM KOPO_MIDDLE_2023_도미솔1

SELECT REPLACE(PRD_SEG3, 'haiteam', '') AS PRD_SEG3
FROM KOPO_MIDDLE_2023_도미솔1

SELECT C.*,
       (ACC8W_QTY_W6 + ACC8W_QTY_W5 + ACC8W_QTY_W4 + ACC8W_QTY_W3 + ACC8W_QTY_W1) / 5 AS ACC_AVG
FROM(
    SELECT B.*,
           FCST_W6 * ACC8W_W6 AS ACC8W_QTY_W6,
           FCST_W5 * ACC8W_W5 AS ACC8W_QTY_W5,
           FCST_W4 * ACC8W_W4 AS ACC8W_QTY_W4,
           FCST_W3 * ACC8W_W3 AS ACC8W_QTY_W3,
           FCST_W2 * ACC8W_W2 AS ACC8W_QTY_W2,
           FCST_W1 * ACC8W_W1 AS ACC8W_QTY_W1,
           (FCST_W6 + FCST_W5 + FCST_W4 + FCST_W3 + FCST_W2 + FCST_W1) / 6 AS FCST_AVG
    FROM(
        SELECT A.*, 
               ABS(QTY-FCST_W6) AS  ABS8W_W6, 
               ABS(QTY-FCST_W5) AS  ABS8W_W5, 
               ABS(QTY-FCST_W4) AS  ABS8W_W4, 
               ABS(QTY-FCST_W3) AS  ABS8W_W3, 
               ABS(QTY-FCST_W2) AS  ABS8W_W2,
               ABS(QTY-FCST_W1) AS  ABS8W_W1,
               CASE 
                 WHEN FCST_W6 = 0 OR QTY = 0 THEN 0
                 WHEN QTY/FCST_W6 > 2 THEN 0
                 ELSE 1-ABS(QTY-FCST_W6)/FCST_W6
               END AS ACC8W_W6,
               CASE 
                 WHEN FCST_W5 = 0 OR QTY = 0 THEN 0
                 WHEN QTY/FCST_W5 > 2 THEN 0
                 ELSE 1-ABS(QTY-FCST_W5)/FCST_W5
               END AS ACC8W_W5,
               CASE 
                 WHEN FCST_W4= 0 OR QTY = 0 THEN 0
                 WHEN QTY/FCST_W4 > 2 THEN 0
                 ELSE 1-ABS(QTY-FCST_W4)/FCST_W4
               END AS ACC8W_W4,
               CASE 
                 WHEN FCST_W3 = 0 OR QTY = 0 THEN 0
                 WHEN QTY/FCST_W3 > 2 THEN 0
                 ELSE 1-ABS(QTY-FCST_W3)/FCST_W3
               END AS ACC8W_W3,
               CASE 
                 WHEN FCST_W2 = 0 OR QTY = 0 THEN 0
                 WHEN QTY/FCST_W2 > 2 THEN 0
                 ELSE 1-ABS(QTY-FCST_W2)/FCST_W2
               END AS ACC8W_W2,
               CASE 
                 WHEN FCST_W1 = 0 OR QTY = 0 THEN 0
                 WHEN QTY/FCST_W1 > 2 THEN 0
                 ELSE 1-ABS(QTY-FCST_W1)/FCST_W1
               END AS ACC8W_W1
        FROM KOPO_MIDDLE_2023_도미솔1 A
    ) B
) C;

