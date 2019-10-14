                                                   /* Creating Tables */
/* Creating the Hitmen table*/
CREATE TABLE HITMEN
(
    Hitman_ID Number(13),
    Hitman_Alias VARCHAR2(50),
    Region VARCHAR2(50),
    Contact_Number VARCHAR2(50),
    Successful_Hits NUMBER(3),
    Speciality VARCHAR2(50),
    Hit_Rate_Cost DECIMAL(6,2)
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
    Client_Number NUMBER(10),
    Client_Total_Debt DECIMAL(6,2)
);

/* Creating the Client_net_cash table*/
CREATE TABLE CLIENT_NET_CASH
(
    Net_Cash_ID NUMBER(13),
    Month1_Income DECIMAL(6,2),
    Month2_Income DECIMAL(6,2),
    Month3_Income DECIMAL(6,2),
    Month1_Expenses DECIMAL(6,2),
    Month2_Expenses DECIMAL(6,2),
    Month3_Expenses DECIMAL(6,2),
    Average_3Month_Cashflow DECIMAL(6,2)
);

/* Creating the Payments*/
CREATE TABLE PAYMENTS
(
    Payment_ID NUMBER(13),
    Client_ID NUMBER(13),
    Payment_Amount DECIMAL(6,2),
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
    Loan_Amount DECIMAL(6,2),
    Total_Payback DECIMAL(6,2)
);

/* Creating the CLIENT_DEBT_HISTORY table*/
CREATE TABLE CLIENT_DEBT_HISTORY
(
    History_ID NUMBER(13),
    Client_ID NUMBER(13) NOT NULL,
    Total_Debt DECIMAL(6,2),
    Total_Paid_Debt DECIMAL(6,2)
);

/* Creating the CLIENT_LOAN table*/
CREATE TABLE CLIENT_LOAN
(
    Loan_ID NUMBER(13),
    Collateral VARCHAR2(250),
    Amt_Paid DECIMAL(6,2),
    Loan_Start_Date DATE,
    Loan_End_Date DATE
);

                                        /* Adding the Primary Key Constraints */
ALTER TABLE HITMEN
ADD CONSTRAINT hitman_id
PRIMARY KEY(Hitman_ID);

ALTER TABLE CLIENT_NET_CASH
ADD CONSTRAINT client_net_cash_pk
PRIMARY KEY(Net_Cash_ID);

ALTER TABLE PAYMENTS
ADD CONSTRAINT payment_id
PRIMARY KEY(Payment_ID);

ALTER TABLE CLIENTS
ADD CONSTRAINT client_id_pk
PRIMARY KEY(Client_ID);

ALTER TABLE LOAN_OPTIONS
ADD CONSTRAINT loan_option_id_pk
PRIMARY KEY(Loan_ID);

ALTER TABLE CLIENT_DEBT_HISTORY
ADD CONSTRAINT history_id_pk
PRIMARY KEY(History_ID);

ALTER TABLE CLIENT_LOAN
ADD CONSTRAINT client_loan_id_pk
PRIMARY KEY(Loan_ID);

                                            /* Adding the Foreign Keys */
ALTER TABLE PAYMENTS
ADD CONSTRAINT pay_client_id_fk
FOREIGN KEY(Client_ID)
REFERENCES CLIENT_PAYMENTS(Client_ID);

                                            /* Bridge Table HITMEN_CLIENT */
ALTER TABLE HITMEN_CLIENT
ADD CONSTRAINT bridge_hitman_id_pk
PRIMARY KEY(Hitman_ID);

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

                                            /* Bridge Table CLIENT_PAYMENTS */
ALTER TABLE CLIENT_PAYMENTS
ADD CONSTRAINT bridge_client_payment_id_pk
PRIMARY KEY(Client_ID);

ALTER TABLE CLIENT_PAYMENTS
ADD CONSTRAINT bridge_client_payment_id_fk
FOREIGN KEY(Client_ID)
REFERENCES CLIENTS(Client_ID);

ALTER TABLE CLIENT_PAYMENTS
ADD CONSTRAINT bridge_payment_id_pk
PRIMARY KEY(Payment_ID);

ALTER TABLE CLIENT_PAYMENTS
ADD CONSTRAINT bridge_payment_id_fk
FOREIGN KEY(Payment_ID)
REFERENCES PAYMENTS(Payment_ID);

ALTER TABLE CLIENTS
ADD CONSTRAINT loan_id_fk
FOREIGN KEY(Loan_ID)
REFERENCES CLIENT_LOAN(Loan_ID);

ALTER TABLE CLIENTS
ADD CONSTRAINT hitman_id_fk
FOREIGN KEY(Hitman_ID)
REFERENCES HITMEN_CLIENT(Hitman_ID);

ALTER TABLE CLIENTS
ADD CONSTRAINT history_id_fk
FOREIGN KEY(History_ID)
REFERENCES CLIENT_DEBT_HISTORY(History_ID);

ALTER TABLE CLIENTS
ADD CONSTRAINT net_cash_id_fk
FOREIGN KEY(Net_Cash_ID)
REFERENCES CLIENT_NET_CASH(Net_Cash_ID);

ALTER TABLE CLIENT_DEBT_HISTORY
ADD CONSTRAINT client_id_fk
FOREIGN KEY(Client_ID)
REFERENCES CLIENTS(Client_ID);

/* Factual Table Creation */

/* Manager Role to view summarized data */
CREATE ROLE manager;

GRANT create table, create view
TO manager;

GRANT manager TO JEANDRE; /* Add laptop owners name for demo!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

/* Factual Table for Hitmen in Region */


