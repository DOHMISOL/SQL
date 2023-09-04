CREATE TABLE CUSTOMERDATA(
    CUSTID VARCHAR2(200),
    AVERAGEPRICE NUMBER,
    EMI NUMBER,
    DEVICECOUNT NUMBER,
    PRODUCTAGE NUMBER,
    CUSTTYPE NUMBER
    )
    
SELECT *
FROM CUSTOMERDATA

CREATE TABLE KOPO_ST_DDL_DMS (
    PRODUCT VARCHAR2(40),
    YEARWEEK VARCHAR2(6),
    VOLUME NUMBER,
     REG_DT DATE DEFAULT SYSDATE
)


SELECT *
FROM KOPO_ST_DDL_DMS

CREATE TABLE 기본(
    컬럼1 NUMBER,
    컬럼2 VARCHAR2(10),
    컬럼3 DATE)
    
SELECT *
FROM 기본

CREATE TABLE KOPO_ST_DDL_DMS3 AS
SELECT DISTINCT PRODUCT, YEARWEEK, VOLUME FROM KOPO_ST_DDL_DMS;

SELECT *
FROM KOPO_ST_DDL_DMS3

CREATE TABLE KOPO_CUSTOMERDATA_DMS AS
SELECT * FROM CUSTOMERDATA

SELECT * 
FROM KOPO_CUSTOMERDATA_DMS

ALTER TABLE KOPO_CUSTOMERDATA_DMS
ADD(DESCRIPTION VARCHAR2(100) DEFAULT 'INDO');

ALTER TABLE KOPO_CUSTOMERDATA_DMS
    RENAME COLUMN DESCRIPTION TO NATION;

ALTER TABLE KOPO_CUSTOMERDATA_DMS
ADD(DESCRIPTION VARCHAR2(100) DEFAULT 'NORMAL');

ALTER TABLE KOPO_CUSTOMERDATA_DMS
MODIFY(DESCRIPTION VARCHAR2(1000));

DESC KOPO_CUSTOMERDATA_DMS

ALTER TABLE KOPO_CUSTOMERDATA_DMS
DROP COLUMN NATION;

ALTER TABLE KOPO_CUSTOMERDATA_DMS
CASCADE CONSTRAINTS;

SELECT *
FROM KOPO_CUSTOMERDATA_DMS

ALTER TABLE KOPO_CUSTOMERDATA_DMS
MODIFY(CUSTTYPE VARCHAR2(1000));

INSERT INTO KOPO_CUSTOMERDATA_DMS
VALUES('A13566', 4273.9, 3, 6.4, 1.6793524415, 'Big-Screen-lover','person')

TRUNCATE TABLE KOPO_CUSTOMERDATA_DMS

DROP TABLE KOPO_CUSTOMERDATA_DMS