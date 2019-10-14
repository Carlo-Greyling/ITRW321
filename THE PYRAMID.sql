                                                    /* Creating Tables */
/* Creating the Hitmen table*/
CREATE TABLE HITMEN
(
    Hitman_ID Number(13),
    Hitman_Alias VARCHAR2(50),
    Region VARCHAR2(50),
    Contact_Number VARCHAR2(12),
    Successful_Hits NUMBER(3),
    Speciality VARCHAR2(50),
    Hit_Rate_Cost DECIMAL(8,2)
);

/* Creating the Hitmen_Client table */
CREATE TABLE HITMEN_CLIENT
(
    Client_ID NUMBER(13) NOT NULL,
    Hitman_ID NUMBER(13) NOT NULL
);

/* Creating the Clients table*/
CREATE TABLE CLIENTS 
(
    Client_ID NUMBER(13) NOT NULL,
    Loan_ID NUMBER(13),
    Hitman_ID NUMBER(13),
    History_ID NUMBER(13),
    Net_Cash_ID NUMBER(13) NOT NULL,
    Client_FName VARCHAR2(50),
    Client_LName VARCHAR2(50),
    Client_Region VARCHAR2(50),
    Client_Number NUMBER(18),
    Client_Total_Debt DECIMAL(8,2)
);

/* Creating the Client_net_cash table*/
CREATE TABLE CLIENT_NET_CASH
(
    Net_Cash_ID NUMBER(13),
    Month1_Income DECIMAL(8,2),
    Month2_Income DECIMAL(8,2),
    Month3_Income DECIMAL(8,2),
    Month1_Expenses DECIMAL(8,2),
    Month2_Expenses DECIMAL(8,2),
    Month3_Expenses DECIMAL(8,2),
    Average_3Month_Cashflow DECIMAL(8,2)
);

/* Creating the Payments*/
CREATE TABLE PAYMENTS
(
    Payment_ID NUMBER(13),
    Client_ID NUMBER(13),
    Payment_Amount DECIMAL(8,2),
    Payment_Date DATE
);

/* Creating the Client_Payments table*/
CREATE TABLE CLIENT_PAYMENTS
(
    Payment_ID NUMBER(13) NOT NULL,
    Client_ID NUMBER(13) NOT NULL
);

/* Creating the Loan_Options table*/
CREATE TABLE Loan_Options
(
    Loan_ID NUMBER(13),
    Loan_Name VARCHAR2(25),
    Loan_Amount DECIMAL(8,2),
    Total_Payback DECIMAL(8,2)
);

/* Creating the CLIENT_DEBT_HISTORY table*/
CREATE TABLE CLIENT_DEBT_HISTORY
(
    History_ID NUMBER(13),
    Client_ID NUMBER(13) NOT NULL,
    Total_Debt DECIMAL(8,2),
    Total_Paid_Debt DECIMAL(8,2)
);

/* Creating the CLIENT_LOAN table*/
CREATE TABLE CLIENT_LOAN
(
    Loan_ID NUMBER(13),
    Collateral VARCHAR2(250),
    Amt_Paid DECIMAL(8,2),
    Loan_Start_Date DATE,
    Loan_End_Date DATE
);

                                        /* Adding the Primary Key Constraints */
/* Hitmen Primary Key Constraints */
ALTER TABLE HITMEN
ADD CONSTRAINT hitman_id
PRIMARY KEY(Hitman_ID);

/* CLIENT_NET_CASH Primary Key Constraints */
ALTER TABLE CLIENT_NET_CASH
ADD CONSTRAINT client_net_cash_pk
PRIMARY KEY(Net_Cash_ID);

/* PAYMENTS Primary Key Constraints */
ALTER TABLE PAYMENTS
ADD CONSTRAINT payment_id
PRIMARY KEY(Payment_ID);

/* CLIENTS Primary Key Constraints */
ALTER TABLE CLIENTS
ADD CONSTRAINT client_id_pk
PRIMARY KEY(Client_ID);

/* LOAN_OPTIONS Primary Key Constraints */
ALTER TABLE LOAN_OPTIONS
ADD CONSTRAINT loan_option_id_pk
PRIMARY KEY(Loan_ID);

/* CLIENT_DEBT_HISTORY Primary Key Constraints */
ALTER TABLE CLIENT_DEBT_HISTORY
ADD CONSTRAINT history_id_pk
PRIMARY KEY(History_ID);

/* CLIENT_LOAN Primary Key Constraints */
ALTER TABLE CLIENT_LOAN
ADD CONSTRAINT client_loan_id_pk
PRIMARY KEY(Loan_ID);

                                            /* Adding the Foreign Keys */
/* PAYMENTS Foreign Key Constraints */
ALTER TABLE PAYMENTS
ADD CONSTRAINT pay_client_id_fk
FOREIGN KEY(Client_ID)
REFERENCES CLIENT_PAYMENTS(Client_ID);

/* CLIENTS Foreign Key Constraints */
ALTER TABLE CLIENTS
ADD CONSTRAINT loan_id_fk
FOREIGN KEY(Loan_ID)
REFERENCES CLIENT_LOAN(Loan_ID);

/* CLIENTS Foreign Key Constraints */
ALTER TABLE CLIENTS
ADD CONSTRAINT hitman_id_fk
FOREIGN KEY(Hitman_ID)
REFERENCES HITMEN_CLIENT(Hitman_ID);

/* CLIENTS Foreign Key Constraints */
ALTER TABLE CLIENTS
ADD CONSTRAINT history_id_fk
FOREIGN KEY(History_ID)
REFERENCES CLIENT_DEBT_HISTORY(History_ID);

/* CLIENTS Foreign Key Constraints */
ALTER TABLE CLIENTS
ADD CONSTRAINT net_cash_id_fk
FOREIGN KEY(Net_Cash_ID)
REFERENCES CLIENT_NET_CASH(Net_Cash_ID);

/* CLIENT_DEBT_HISTORY Foreign Key Constraints */
ALTER TABLE CLIENT_DEBT_HISTORY
ADD CONSTRAINT client_id_fk
FOREIGN KEY(Client_ID)
REFERENCES CLIENTS(Client_ID);

                                            /* Bridge Table HITMEN_CLIENT */
/*ALTER TABLE HITMEN_CLIENT
ADD CONSTRAINT bridge_hitman_id_pk
PRIMARY KEY(Hitman_ID);*/

ALTER TABLE HITMEN_CLIENT
ADD CONSTRAINT bridge_hitman_id_fk
FOREIGN KEY(Hitman_ID)
REFERENCES HITMEN(Hitman_ID);

ALTER TABLE HITMEN_CLIENT
ADD CONSTRAINT bridge_client_id_pk
PRIMARY KEY(Client_ID);

ALTER TABLE HITMEN_CLIENT
ADD CONSTRAINT bridge_client_id_fk
FOREIGN KEY(Client_ID)
REFERENCES CLIENTS(Client_ID);
                                                /* END of Bridge Table */

                                            /* Bridge Table CLIENT_PAYMENTS */
ALTER TABLE CLIENT_PAYMENTS
ADD CONSTRAINT bridge_client_payment_id_pk
PRIMARY KEY(Client_ID);

ALTER TABLE CLIENT_PAYMENTS
ADD CONSTRAINT bridge_client_payment_id_fk
FOREIGN KEY(Client_ID)
REFERENCES CLIENTS(Client_ID);

/*ALTER TABLE CLIENT_PAYMENTS
ADD CONSTRAINT bridge_payment_id_pk
PRIMARY KEY(Payment_ID);*/

ALTER TABLE CLIENT_PAYMENTS
ADD CONSTRAINT bridge_payment_id_fk
FOREIGN KEY(Payment_ID)
REFERENCES PAYMENTS(Payment_ID);
                                                /* END of Bridge Table */
                                                /*CREATION OF FACTUAL TABLES */
CREATE TABLE FACT_HIT_BY_PROVINCE
(
    Province VARCHAR2(50),
    Total_Hits Number(13)
    
);

CREATE TABLE Fact_Twenty_Percent_Debt AS
(
    SELECT c.Client_ID AS Client_ID, 
    c.Client_FName AS FName, 
    c.Client_LName AS LName, 
    c.Client_Region AS Client_Region, 
    c.Client_Total_Debt AS Client_Total_Debt, 
    ROUND((100 / c.Client_Total_Debt * l.Amt_Paid), 2) AS Client_Debt_Percentage,
    EXTRACT(MONTH FROM (SELECT SYSDATE FROM DUAL)) - EXTRACT(MONTH FROM l.Loan_Start_Date) AS Months_Elapsed
    FROM CLIENTS c
    JOIN CLIENT_LOAN l
    ON (c.Loan_ID = l.Loan_ID)
    WHERE 100 / c.Client_Total_Debt * l.Amt_Paid BETWEEN 20 AND 49
);

CREATE TABLE Fact_Fifty_Percent_Debt AS
(
    SELECT c.Client_ID AS Client_ID, 
    c.Client_FName AS FName, 
    c.Client_LName AS LName, 
    c.Client_Region AS Client_Region, 
    c.Client_Total_Debt AS Client_Total_Debt, 
    ROUND((100 / c.Client_Total_Debt * l.Amt_Paid), 2) AS Client_Debt_Percentage,
    EXTRACT(MONTH FROM (SELECT SYSDATE FROM DUAL)) - EXTRACT(MONTH FROM l.Loan_Start_Date) AS Months_Elapsed
    FROM CLIENTS c
    JOIN CLIENT_LOAN l
    ON (c.Loan_ID = l.Loan_ID)
    WHERE 100 / c.Client_Total_Debt * l.Amt_Paid BETWEEN 50 AND 79
);

CREATE TABLE Fact_Eighty_Percent_Debt AS
(
    SELECT c.Client_ID AS Client_ID, 
    c.Client_FName AS FName, 
    c.Client_LName AS LName, 
    c.Client_Region AS Client_Region, 
    c.Client_Total_Debt AS Client_Total_Debt, 
    ROUND((100 / c.Client_Total_Debt * l.Amt_Paid), 2) AS Client_Debt_Percentage,
    EXTRACT(MONTH FROM (SELECT SYSDATE FROM DUAL)) - EXTRACT(MONTH FROM l.Loan_Start_Date) AS Months_Elapsed
    FROM CLIENTS c
    JOIN CLIENT_LOAN l
    ON (c.Loan_ID = l.Loan_ID)
    WHERE 100 / c.Client_Total_Debt * l.Amt_Paid BETWEEN 80 AND 100
);

CREATE TABLE FACT_INCOME_BY_REGION
(
    Province VARCHAR2(50),
    Total_Income Number(13)
);

CREATE TABLE FACT_LOAN_LOSS_WHEN_HIT AS
(
    SELECT c.client_id AS Client_ID, c.client_total_debt AS Client_Current_Dept, c.Client_Total_Dept - l.amt_paid + h.hit_rate_cost AS Total_Loss_per_Hit
    FROM CLIENTS c
    JOIN CLIENT_LOAN l
    ON (c.Loan_ID = l.Loan_ID)
    LEFT JOIN HITMEN h ON (c.loan_ID = h.hitman_id)
);


/* Create fact table for FACT_DEPT_HISTORY */
CREATE TABLE FACT_DEPT_HISTORY
(
Client_ID NUMBER(13) NOT NULL,
Client_Region VARCHAR2(50),
Client_Total_Debt DECIMAL(8,2)
);

/* Create Fact table for FACT_LOAN_HISTORY */
CREATE TABLE FACT_LOAN_HISTORY
(
Client_ID NUMBER(13) NOT NULL,
Loan_Date DATE,
Loan_Amount DECIMAL(8,2),
Client_FName VARCHAR2(50),
Client_LName VARCHAR2(50),
Client_Region VARCHAR2(50)
);

                                                /*DROP FACTUAL TABLES */
DROP TABLE FACT_HIT_BY_PROVINCE;

                                                /* INSERT DATA INTO FACTUAL TABLES 
/* Fact_Income_By_Region */
INSERT INTO FACT_INCOME_BY_REGION
    (Province, Total_Income)
VALUES (
    (SELECT DISTINCT region FROM clients WHERE region = 'North West'),
    (SELECT SUM(Average_3Month_Cashflow) FROM client_net_cash WHERE region= 'North West')/*client_net_cash moet seker ge merge word met iets om te kan werk? */
    );

INSERT INTO FACT_INCOME_BY_REGION
    (Province, Total_Income)
VALUES (
    (SELECT DISTINCT region FROM clients WHERE region = 'Freestate '),
    (SELECT SUM(Average_3Month_Cashflow) FROM client_net_cash WHERE region = 'Freestate')
    );

INSERT INTO FACT_INCOME_BY_REGION
    (Province, Total_Income)
VALUES (
    (SELECT DISTINCT region FROM clients WHERE region = 'Limpopo'),
    (SELECT SUM(Average_3Month_Cashflow) FROM client_net_cash WHERE region = 'Limpopo')
    );

INSERT INTO FACT_INCOME_BY_REGION
    (Province, Total_Income)
VALUES (
    (SELECT DISTINCT region FROM clients WHERE region = 'Mpumalanga'),
    (SELECT SUM(Average_3Month_Cashflow) FROM client_net_cash WHERE region = 'Mpumalanga')
    );

INSERT INTO FACT_INCOME_BY_REGION
    (Province, Total_Income)
VALUES (
    (SELECT DISTINCT region FROM clients WHERE region = 'Gauteng'),
    (SELECT SUM(Average_3Month_Cashflow) FROM client_net_cash WHERE region = 'Gauteng')
    );

INSERT INTO FACT_INCOME_BY_REGION
    (Province, Total_Income)
VALUES (
    (SELECT DISTINCT region FROM clients WHERE region = 'Kwazulu Natal'),
    (SELECT SUM(Average_3Month_Cashflow) FROM client_net_cash WHERE region = 'Kwazulu Natal')
    );

INSERT INTO FACT_INCOME_BY_REGION
    (Province, Total_Income)
VALUES (
    (SELECT DISTINCT region FROM clients WHERE region = 'Eastern Cape'),
    (SELECT SUM(Average_3Month_Cashflow) FROM client_net_cash WHERE region = 'Eastern Cape')
    );

INSERT INTO FACT_INCOME_BY_REGION
    (Province, Total_Income)
VALUES (
    (SELECT DISTINCT region FROM clients WHERE region = 'Western Cape'),
    (SELECT SUM(Average_3Month_Cashflow) FROM client_net_cash WHERE region = 'Western Cape')
    );

INSERT INTO FACT_INCOME_BY_REGION
    (Province, Total_Income)
VALUES (
    (SELECT DISTINCT region FROM clients WHERE region = 'Northern Cape'),
    (SELECT SUM(Average_3Month_Cashflow) FROM client_net_cash WHERE region = 'Northern Cape')
    );


DROP TABLE FACT_INCOME_BY_REGION CASCADE CONSTRAINTS;

/* Create fact table for DEBT HISTORY*/
CREATE TABLE FACT_DEPT_HISTORY
(
    Client_ID NUMBER(13) NOT NULL,
    Client_Region VARCHAR2(50),
    Client_Total_Debt DECIMAL(8,2)
);

DROP TABLE FACT_DEPT_HISTORY;

/* Data In Table */

INSERT INTO FACT_DEPT_HISTORY
(Client_ID, Client_Region, Client_Total_Dept)
VALUES(
(SELECT CLIENT_ID FROM CLIENTS),
(SELECT CLIENT_TOTAL_DEPT FROM CLIENTS),
(SELECT CLIENT_REGION FROM CLIENTS)
);

DROP TABLE FACT_DEPT_HISTORY CASCADE CONSTRAINTS;


/* fact table to show client loan history*/

CREATE TABLE FACT_LOAN_HISTORY
(
Client_ID NUMBER(13) NOT NULL,
Client_Total_Debt DECIMAL(8,2),
Client_FName VARCHAR2(50),
Client_LName VARCHAR2(50),
Client_Region VARCHAR2(50)
);

DROP TABLE FACT_LOAN_HISTORY;

INSERT INTO FACT_DEPT_HISTORY
(Client_ID, Client_Region, Client_Total_Dept, Client_FName, Client_LName)
VALUES(
(SELECT CLIENT_ID FROM CLIENTS),
(SELECT CLIENT_TOTAL_DEPT FROM CLIENTS),
(SELECT Client_FName FROM CLIENTS),
(SELECT Client_LName FROM CLIENTS),
(SELECT Client_Region FROM CLIENTS)
);

DROP TABLE FACT_LOAN_HISTORY CASCADE CONSTRAINTS;
                                        
/* FACT_HITS_BY_PROVINCE */
INSERT INTO FACT_HIT_BY_PROVINCE
    (Province, Total_Hits)
VALUES (
    (SELECT DISTINCT region FROM hitmen WHERE region = 'North West'),
    (SELECT COUNT(Successful_Hits) FROM hitmen WHERE region = 'North West')
    );
    
INSERT INTO FACT_HIT_BY_PROVINCE
    (Province, Total_Hits, Clients)
VALUES (
    (SELECT DISTINCT region FROM hitmen WHERE region = 'Freestate'),
    (SELECT COUNT(Successful_Hits) FROM hitmen WHERE region = 'Freestate')
    );
    
INSERT INTO FACT_HIT_BY_PROVINCE
    (Province, Total_Hits)
VALUES (
    (SELECT DISTINCT region FROM hitmen WHERE region = 'Limpopo'),
    (SELECT COUNT(Successful_Hits) FROM hitmen WHERE region = 'Limpopo')
    );
    
INSERT INTO FACT_HIT_BY_PROVINCE
    (Province, Total_Hits)
VALUES (
    (SELECT DISTINCT region FROM hitmen WHERE region = 'Mpumalanga'),
    (SELECT COUNT(Successful_Hits) FROM hitmen WHERE region = 'Mpumalanga')
    );
    
INSERT INTO FACT_HIT_BY_PROVINCE
    (Province, Total_Hits)
VALUES (
    (SELECT DISTINCT region FROM hitmen WHERE region = 'Gauteng'),
    (SELECT COUNT(Successful_Hits) FROM hitmen WHERE region = 'Gauteng')
    );
    
INSERT INTO FACT_HIT_BY_PROVINCE
    (Province, Total_Hits)
VALUES (
    (SELECT DISTINCT region FROM hitmen WHERE region = 'Kwazulu Natal'),
    (SELECT COUNT(Successful_Hits) FROM hitmen WHERE region = 'Kwazulu Natal')
    );
    
INSERT INTO FACT_HIT_BY_PROVINCE
    (Province, Total_Hits)
VALUES (
    (SELECT DISTINCT region FROM hitmen WHERE region = 'Eastern Cape'),
    (SELECT COUNT(Successful_Hits) FROM hitmen WHERE region = 'Eastern Cape')
    );
    
INSERT INTO FACT_HIT_BY_PROVINCE
    (Province, Total_Hits)
VALUES (
    (SELECT DISTINCT region FROM hitmen WHERE region = 'Western Cape'),
    (SELECT COUNT(Successful_Hits) FROM hitmen WHERE region = 'Western Cape')
    );
    
INSERT INTO FACT_HIT_BY_PROVINCE
    (Province, Total_Hits)
VALUES (
    (SELECT DISTINCT region FROM hitmen WHERE region = 'Northern Cape'),
    (SELECT COUNT(Successful_Hits) FROM hitmen WHERE region = 'Northern Cape')
    );*/
    
/* DROPPING ALL TABLES*/
DROP TABLE FACT_HIT_BY_PROVINCE CASCADE CONSTRAINTS;


DROP TABLE CLIENTS CASCADE CONSTRAINTS;
DROP TABLE CLIENT_DEBT_HISTORY CASCADE CONSTRAINTS;
DROP TABLE CLIENT_LOAN CASCADE CONSTRAINTS;
DROP TABLE CLIENT_NET_CASH CASCADE CONSTRAINTS;
DROP TABLE CLIENT_PAYMENTS CASCADE CONSTRAINTS;
DROP TABLE HITMEN CASCADE CONSTRAINTS;
DROP TABLE HITMEN_CLIENT CASCADE CONSTRAINTS;
DROP TABLE LOAN_OPTIONS CASCADE CONSTRAINTS;
DROP TABLE PAYMENTS CASCADE CONSTRAINTS;