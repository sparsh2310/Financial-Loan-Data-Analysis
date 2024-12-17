-- dataset : https://drive.google.com/drive/folders/1wjjTBUg2SHXJQwVNjI5vHLk6DjI2W7y7

create database financial_loan_db;

select * from financial_loan;

describe financial_loan;

update financial_loan
SET issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y');

ALTER TABLE financial_loan
MODIFY COLUMN last_credit_pull_date DATE;

update financial_loan
SET last_credit_pull_date = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y');

ALTER TABLE financial_loan
MODIFY COLUMN last_credit_pull_date DATE; 


update financial_loan
SET next_payment_date = STR_TO_DATE(next_payment_date, '%d-%m-%Y');

ALTER TABLE financial_loan
MODIFY COLUMN next_payment_date DATE; 

describe financial_loan;

-- 1. Total Loan Applications:
select count(*) as Total_loan_application from financial_loan;



-- 2. MTD Loan Applications: (MTD= current month)
select count(*) as Total_MTD_loan_application from financial_loan
where month(issue_date) = 12;

-- 3. PMTD Loan :(previous month to date or previous month)

select * from financial_loan;
select count(*) as Total_PMTD_loan_application from financial_loan
where month(issue_date) = 11;

-- 4. Total Funded Amount:
select * from financial_loan;
select sum(loan_amount) as Total_Amt_Funded from financial_loan;

-- 5. MTD Total Funded Amount:
select sum(loan_amount) as Total_MTD_Amt_Funded from financial_loan
where month(issue_date)=12;


-- 6. PMTD Total Funded Amount:
select sum(loan_amount) as Total_PMTD_Amt_Funded from financial_loan
where month(issue_date)=11;


-- 7. Total Amount Received:
select sum(total_payment) as Total_Amt_Receive from financial_loan;


-- 8. MTD Total Amount Received:
select sum(total_payment) as Total_MTD_Amt_Receive from financial_loan
where month(issue_date)=12;

-- 9. PMTD Total Amount Received:
select sum(total_payment) as Total_PMTD_Amt_Receive from financial_loan
where month(issue_date)=11;


-- 10.Average Interest Rate:
select * from financial_loan;
select round(avg(int_rate),2) *100 as Avg_int_rate from financial_loan;


-- 11. MTD Average Interest:
select round(avg(int_rate),2) *100 as Avg_MTD_int_rate 
from financial_loan
where month(issue_date)=12;


-- 12. PMTD Average Interest:
select round(avg(int_rate),2) *100 as Avg_PMTD_int_rate 
from financial_loan
where month(issue_date)=11;



-- 13. Avg DTI
select avg(dti)* 100 as Avg_DTI from financial_loan;			

-- 14. MTD Avg DTI
select avg(dti)* 100 as Avg_DTI_MTD
from financial_loan
where month(issue_date)=12;			




-- 15. PMTD Avg DTI
select avg(dti)* 100 as Avg_DTI_PMTD
from financial_loan
where month(issue_date)=11 ;	

-- 16. Good Loan Percentage :
select * from financial_loan;

select (good_loan/total_loan)*100 as Total_percentage_good_loan from
(select count(loan_status) as good_loan
from financial_loan
where loan_status =  'Fully Paid' or loan_status ='Current')as loan_type,
(select count(loan_status) as total_loan from financial_loan) as total_amt;
    
    
   -- 17. Good Loan Applications:
   select  count(loan_status)  as Good_loan_applications from financial_loan
   where loan_status =  'Fully Paid' or loan_status ='Current' ;



-- 18. Good Loan Funded Amount
select  sum(loan_amount)  as Total_amt_Funded_good_loan from financial_loan
   where loan_status =  'Fully Paid' or loan_status ='Current' ;


-- 19. Good Loan Amount Received
select  sum(total_payment)  as Total_amt_receive_good_loan from financial_loan
   where loan_status =  'Fully Paid' or loan_status ='Current' ;


-- 20. Bad Loan Percentage:
select (bad_loan/total_loan)*100 as Total_Percentage_bad_loan 
from(
select count(*)as bad_loan from financial_loan
where loan_status = 'Charged Off') as bad_loan_amt,
(select count(*) as total_loan from financial_loan)as total_amt;



-- 21. Bad Loan Applications:
select  count(*)  as Total_applications_for_bad_loan from financial_loan
   where loan_status = 'Charged Off' ;



-- 22. Bad Loan Funded Amount

select  sum(loan_amount)  as Total_amt_Funded_bad_loan from financial_loan
   where loan_status =  'Charged Off'  ;


-- 23. Bad Loan receive Amount

select  sum(total_payment)  as Total_amt_receive_bad_loan from financial_loan
   where loan_status = 'Charged Off'  ;


-- 24.loan status
select loan_status, 
sum(loan_amount)as Total_Loan_funded,
sum(total_payment) as Total_amt_receive,
avg(int_rate) as Average_interest_rate,
avg(dti) as Avregae_DTI
 from financial_loan
 group by 1;
 
 -- for MTD
 select loan_status, 
sum(loan_amount)as Total_MTD_Loan_funded,
sum(total_payment) as Total_MTD_amt_receive,
avg(int_rate) as Average_MTD_interest_rate,
avg(dti) as Avregae_MTD_DTI
 from financial_loan
 where month(issue_date)=12
 group by 1;

-- 25. BANK LOAN REPORT | OVERVIEW
select month( issue_date) as Month_No , 
count(id) as Total_loan_applications,
sum(loan_amount) as total_loan_amt_funded,
sum(total_payment) as Total_amt_receive 
from financial_loan
group by 1
order by 1;


-- 26.  same as above on basis of state:

select address_state  , 
count(id) as Total_loan_applications,
sum(loan_amount) as total_loan_amt_funded,
sum(total_payment) as Total_amt_receive 
from financial_loan
group by 1
order by 1;

-- 27. same as above on basis of term:
select term  , 
count(id) as Total_loan_applications,
sum(loan_amount) as total_loan_amt_funded,
sum(total_payment) as Total_amt_receive 
from financial_loan
group by 1
order by 1;

-- 28. same as above on basis of emp_length:

select emp_length  , 
count(id) as Total_loan_applications,
sum(loan_amount) as total_loan_amt_funded,
sum(total_payment) as Total_amt_receive 
from financial_loan
group by 1
order by 1;


-- 29. PURPOSE
select purpose  , 
count(id) as Total_loan_applications,
sum(loan_amount) as total_loan_amt_funded,
sum(total_payment) as Total_amt_receive 
from financial_loan
group by 1
order by 1;




