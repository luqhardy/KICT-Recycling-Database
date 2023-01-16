--MOHAMED LUQMAN HADI BIN MOHAMED SUHAIRI 2210855
--MUAZZAM HAZMI
--MIRZA DARWISY
--IRFAN FIRDAUS    
--SYAHIR

--resets all tables and sequences
DROP TABLE WASTE;
DROP TABLE REDEEM;
DROP TABLE POINTS;
DROP TABLE STUDENT;
DROP TABLE PRODUCTS;
DROP TABLE TRANSACTIONS
DROP SEQUENCE "wasteIDSeq";
DROP SEQUENCE "redeemSeq";
DROP SEQUENCE "productSeq";
DROP SEQUENCE "transSeq";

--table creation
CREATE TABLE STUDENT (
STUDENT_ID         INTEGER,
STUDENT_NAME     VARCHAR(100),
STUDENT_POINTS     INTEGER,
STUDENT_PICTURE     BLOB,
mimetype        VARCHAR2(50),
filename        VARCHAR2(100),
created_date    DATE,
PRIMARY KEY (STUDENT_ID)
);

CREATE TABLE WASTE (
WASTE_ID         NUMBER(5),
WASTE_DATETIME  DATE DEFAULT SYSDATE NOT NULL,
WASTE_QTY       NUMBER,
WASTE_LOCATION  VARCHAR(40),
WASTE_TYPE      VARCHAR(40),
WASTE_PICTURE   BLOB,
STUDENT_ID      INTEGER,
mimetype        VARCHAR2(50),
filename        VARCHAR2(100),
created_date    DATE,
PRIMARY KEY (WASTE_ID)
);

CREATE TABLE PRODUCTS (
PRODUCTS_ID       INTEGER,
PRODUCTS_NAME     VARCHAR(40),
PRODUCTS_QTY      INTEGER,
PRODUCTS_POINTS   INTEGER,
PRODUCTS_PICTURE  BLOB,
mimetype        VARCHAR2(50),
filename        VARCHAR2(100),
created_date    DATE,
PRIMARY KEY (PRODUCTS_ID)
);

CREATE TABLE REDEEM (
REDEEM_ID       INTEGER,
PRODUCTS_ID      INTEGER,
STUDENT_ID      INTEGER,
PRIMARY KEY (REDEEM_ID),
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
FOREIGN KEY (PRODUCTS_ID) REFERENCES PRODUCTS(PRODUCTS_ID)
);

CREATE TABLE POINTS (
STUDENT_ID       INTEGER,
POINTS_QTY       INTEGER,
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID)
);

CREATE TABLE TRANSACTIONS (
TRANS_ID INTEGER,
STUDENT_ID INTEGER,
POINTS_BEFORE INTEGER,
POINTS_CURRENT INTEGER,

PRIMARY KEY (TRANS_ID),
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID)
);

--sequence declaration
CREATE SEQUENCE "wasteIDSeq"
MINVALUE 1
MAXVALUE 99999
INCREMENT BY 1
START WITH 1
CACHE 20
;
CREATE SEQUENCE "redeemSeq"
MINVALUE 1
MAXVALUE 99999
INCREMENT BY 1
START WITH 1
CACHE 20
;
CREATE SEQUENCE "productSeq"
MINVALUE 1
MAXVALUE 99999
INCREMENT BY 1
START WITH 1
CACHE 20
;
CREATE SEQUENCE "transSeq"
MINVALUE 1
MAXVALUE 99999
INCREMENT BY 1
START WITH 1
CACHE 20
;

create or replace TRIGGER UpdateStudentPoints_Redeem
AFTER INSERT
   ON REDEEM
   FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    UPDATE STUDENT SET STUDENT_POINTS = STUDENT_POINTS - (SELECT PRODUCT_POINTS FROM PRODUCTS WHERE PRODUCTS_ID = :NEW.PRODUCTS_ID)  WHERE STUDENT_ID = :NEW.STUDENT_ID;
    COMMIT;
END;

create or replace TRIGGER UpdateStudentPoints
AFTER INSERT
   ON WASTE
   FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    UPDATE WASTE SET POINTS_BEFORE = (SELECT STUDENT_POINTS FROM STUDENT WHERE STUDENT_ID = :NEW.STUDENT_ID) WHERE WASTE_DATETIME = (SELECT WASTE_DATETIME FROM WASTE ORDER BY WASTE_DATETIME DESC FETCH FIRST 1 ROWS ONLY);
    UPDATE STUDENT SET STUDENT_POINTS = STUDENT_POINTS + 1 WHERE STUDENT_ID = :NEW.STUDENT_ID;
    UPDATE WASTE SET POINTS_AFTER = (SELECT STUDENT_POINTS FROM STUDENT WHERE STUDENT_ID = :NEW.STUDENT_ID) WHERE WASTE_DATETIME = (SELECT WASTE_DATETIME FROM WASTE ORDER BY WASTE_DATETIME DESC FETCH FIRST 1 ROWS ONLY);
    COMMIT;
END;



--TEST VALUES (15 as stated) (for student)
INSERT INTO STUDENT VALUES(2210855,'MOHAMED LUQMAN HADI BIN SUHAIRI',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2218867,'MIRZA DARWISY BIN MAHAZIR',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2214771,'MUHAMMAD SYAHIR BIN MOHD KAMAL',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2219361,'MUAZZAM HAZMI BIN SUKHAIMI',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2218453,'MOHAMAD IRFAN FIRDAUS BIN MOHD BASRI',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2210856,'MOHAMAD LUQMAN HAKIM BIN SUHAILI',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2218868,'MIRZU DARWISH BIN MAHADIR',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2214772,'AHMAD SYAH BIN ABDUL KAMAL',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2219362,'ZAM ZAHMIL BIN SUHAIMI',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2218454,'AHMEDIAH ARFANIAH DAULAN BINTI AHMAD BASRAN',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2210866,'AHMAD LUKMAN HAFIZ BIN SUHAILAN',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2218878,'MIRZAN DAHLAN BIN MAHADTIR',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2214782,'AHMADIAH SYAHDIAH BIN ABDULLAH KAMAL',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2219392,'ZAHMAD ZAHMIL BIN AHMAD SUHAILAN',0,null,null,null,null);
INSERT INTO STUDENT VALUES(2218484,'NUR IRFANIAH DAUS BINTI MOHD BASRAN',0,null,null,null,null);
--TEST VALUES (Product, 15)
INSERT INTO PRODUCTS VALUES(1,'Tomato',100,null,null,null,null);
INSERT INTO PRODUCTS VALUES(2,'Sunflower',150,null,null,null,null);
INSERT INTO PRODUCTS VALUES(3,'Rice',500,null,null,null,null);
INSERT INTO PRODUCTS VALUES(4,'Apple',150,null,null,null,null);
INSERT INTO PRODUCTS VALUES(5,'Raspberry',100,null,null,null,null);
INSERT INTO PRODUCTS VALUES(6,'Blueberry',150,null,null,null,null);
INSERT INTO PRODUCTS VALUES(7,'Rambutan',100,null,null,null,null);
INSERT INTO PRODUCTS VALUES(8,'Durian',150,null,null,null,null);
INSERT INTO PRODUCTS VALUES(9,'',100,null,null,null,null);
INSERT INTO PRODUCTS VALUES(10,'Sunflower',150,null,null,null,null);
INSERT INTO PRODUCTS VALUES(11,'Tomato',100,null,null,null,null);
INSERT INTO PRODUCTS VALUES(12,'Sunflower',150,null,null,null,null);
INSERT INTO PRODUCTS VALUES(13,'Tomato',100,null,null,null,null);
INSERT INTO PRODUCTS VALUES(14,'Sunflower',150,null,null,null,null);
INSERT INTO PRODUCTS VALUES(15,'Tomato',100,null,null,null,null);
--TEST VALUES (Waste, 15) WASTE_ID
INSERT INTO WASTE VALUES(1,'1998-12-25',1,'Malhallah Ali','Traffic Cone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(2,'1998-12-26',1,'Malhallah Othman','Laptop',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(3,'1998-12-27',1,'Malhallah Ali','Phone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(4,'1998-12-25',1,'KICT','Traffic Cone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(5,'1998-12-26',1,'KAED','Laptop',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(6,'1998-12-27',1,'OSEM','Phone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(7,'1998-12-25',1,'OSEM','Traffic Cone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(8,'1998-12-26',1,'KICT','Laptop',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(9,'1998-12-27',1,'Malhallah Siddiq','Phone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(10,'1998-12-25',1,'Malhallah Siddiq','Traffic Cone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(11,'1998-12-26',1,'Malhallah Othman','Laptop',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(12,'1998-12-27',1,'Malhallah Siddiq','Phone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(13,'1998-12-27',1,'Dar Al-Hikmah Library','Phone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(14,'1998-12-27',1,'Gansu Mee Tarik','Phone',null,2210855,null,null,null);
INSERT INTO WASTE VALUES(15,'1998-12-27',1,'Malhallah Ali','Phone',null,2210855,null,null,null);

COMMIT;​
