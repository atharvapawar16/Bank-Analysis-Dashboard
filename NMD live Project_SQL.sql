use FirstLiveProject; -- created 


 ---------accountsdata------------
-- order of execution of sql query
From -> join -> where -> group by -> having -> select -> distinct -> order by
-- order of writing query
select -> from -> where -> group by -> having -> order by

select * from accountsdata;  -- total data of accountsdata table

select * from accountsdata where account_id is NULL; -- to find account id null data

select * from accountsdata where customer_id is NULL;  --  to find customer id null data

Select distinct * from accountsdata; -- to find ditinct account data

select count(*) from accountsdata; --  to find count of accounts data

select * from accountsdata where account_id = ''; -- to find data where account id is not present

delete from accountsdata where account_id = ''; -- to delete data where account id is not present

delete from accountsdata where account_id not in (Select distinct(account_id) from accountsdata); 

create table daccountdata as (select distinct * from accountsdata);
select * from daccountdata;

select customer_id, branch_id, account_type, balance from accountsdata group by customer_id, branch_id, account_type, balance having count(customer_id)>=1;


select * from accountsdata;
rollback;
DELETE FROM accountsdata 
WHERE account_id NOT IN (SELECT min(account_id) FROM accountsdata group by account_id);

DELETE FROM accountsdata 
WHERE account_id IN (
SELECT account_id 
FROM accountsdata
GROUP BY account_id
HAVING COUNT(account_id) >= 2);

select a.*,row_number() over() as rn from accountsdata a ;

DELETE FROM accountsdata where account_ID IN (select account_id from accountsdata group by account_id having count(account_Id)>=2);


-- branches--------------

select * from branches; -- to view data for branch table, data is clean so no changes required.

-- customersdata ---------

select * from customersdata;
delete from customersdata where customer_id ='';
select distinct * from customersdata;
create table dcustomersdata as (select distinct * from customersdata);
select * from dcustomersdata;
select count(phone),phone from dcustomersdata group by phone having count(phone)>2;
select count(phone),phone from dcustomersdata group by phone having count(phone)>1; ---------------
select first_name,last_name,email,phone from dcustomersdata group by phone,first_name,last_name,email having count(phone)>2;

select customer_id,phone from dcustomersdata group by customer_id having count(customer_id)>=1;

select * from dcustomersdata where length(phone)<12 ;
select * from dcustomersdata where length(phone)<11 ;

select distinct(email) from dcustomersdata;

select count(email),email from dcustomersdata group by email having count(email)>2;
select * from dcustomersdata where email ='';

-- kyc ----------------

select * from kyc; --- to view kyc data total 500 fows 
select distinct * from kyc; -- to check disctinct data (500 rows)

-- loans1 ------------

select * from loans1;-- total 564 data 

select * from loans1 where loan_id =''; -- to check rows which does not have loan_id --14 rows in result since it is having customer id we are not deleting the rows. seems data is genuine.

-- payments -------------
select * from payments; -- got 2000 rows

select distinct * from payments;

-- Transactionsdata--------------

select * from Transactionsdata; -- 2061 data

select distinct * from Transactionsdata; -- 2000 rows received

select distinct * from Transactionsdata;

-- select transaction_id from Transactionsdata where transaction_id not in (select transaction_id distinct * from Transactionsdata);


select count(transaction_id),account_id from Transactionsdata group by transaction_id, account_id having count(transaction_id)>1;

select customer_id,phone from dcustomersdata group by customer_id having count(customer_id)>=1;

-- delete from Transactionsdata where transaction_id not in (select distinct * from Transactionsdata); 

create table dtransactionsdata as (select distinct * from Transactionsdata);

select * from dtransactionsdata;

-- Final tables

select * from daccountdata; -- 1000
select * from branches; -- 10
select * from dcustomersdata; -- 1005
select * from loans1; -- 564
select * from payments; -- 2000
select * from dtransactionsdata; -- 2000

-- Data alteration

-- daccountdata -------
ALTER TABLE daccountdata  MODIFY COLUMN account_id int; 
ALTER TABLE daccountdata  MODIFY COLUMN customer_id int; 
ALTER TABLE daccountdata  MODIFY COLUMN branch_id int; 
ALTER TABLE daccountdata  MODIFY COLUMN account_type varchar(20);

-- branches -----

ALTER TABLE branches MODIFY COLUMN branch_name varchar(20); 
ALTER TABLE branches MODIFY COLUMN branch_address varchar(40); 

-- dcustomersdata ---------

ALTER TABLE dcustomersdata MODIFY COLUMN customer_id int; 
ALTER TABLE dcustomersdata MODIFY COLUMN first_name varchar(20); 
ALTER TABLE dcustomersdata MODIFY COLUMN last_name varchar(20); 
ALTER TABLE dcustomersdata MODIFY COLUMN email varchar(50); 
ALTER TABLE dcustomersdata MODIFY COLUMN phone varchar(52); 
ALTER TABLE dcustomersdata MODIFY COLUMN address varchar(200);

-- loans1 ---------

ALTER TABLE loans1 MODIFY COLUMN loan_id varchar(10); 
ALTER TABLE loans1 MODIFY COLUMN customer_id int; 
ALTER TABLE loans1 MODIFY COLUMN loan_type varchar(10);
ALTER TABLE loans1 MODIFY COLUMN loan_amount double;
ALTER TABLE loans1 MODIFY COLUMN interest_rate varchar(10);
ALTER TABLE loans1 MODIFY COLUMN loan_status varchar(10);

commit;

-- payments ------------
ALTER TABLE payments MODIFY COLUMN payment_id int; 
ALTER TABLE payments MODIFY COLUMN loan_id int;
ALTER TABLE payments MODIFY COLUMN payment_amount double;


-- dtransactionsdata ---------

ALTER TABLE dtransactionsdata MODIFY COLUMN transaction_id int; 
ALTER TABLE dtransactionsdata MODIFY COLUMN account_id int;
ALTER TABLE dtransactionsdata MODIFY COLUMN transaction_type varchar(20);