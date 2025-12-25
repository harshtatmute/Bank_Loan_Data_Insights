create database BankLoan;
use BankLoan;

select * from financial_loan;
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'financial_loan';

-- total number loan of application
select count(id) as Num_Loan_Application
from financial_loan;

-- loan applications for december month 2021 (latest year and month)
select count(id) as MTD_loan_application
from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;

-- previous month
select count(id) as MTD_loan_application
from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021;

-- Total Funded Amount
select sum(loan_amount) as Tot_funded_amt 
from financial_loan;

-- MTD Total Funded Amount
select sum(loan_amount) as Tot_funded_amt 
from financial_loan
where month(issue_date) = 12;

select sum(total_payment) as Total_payment_recieved 
from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021;

-- Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI FROM financial_loan;

-- MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 12;

-- Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM financial_loan;

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM financial_loan;
 
-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM financial_loan
WHERE loan_status = 'Charged Off';

-- Loan Status
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        financial_loan
    GROUP BY
        loan_status;

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

-- Dashboard 2 
-- MONTH
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	monthname(issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY MONTH(issue_date), monthname(issue_date)
ORDER BY MONTH(issue_date);

-- STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;

-- HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY home_ownership;

