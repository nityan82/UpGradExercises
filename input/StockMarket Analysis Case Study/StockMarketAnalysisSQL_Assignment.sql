-- This runs on oracle 12c and tested via sql developer
-- Scheme is assignment
use assignment;
-- The csv files have been imported as below tables, and the format were changed for each column during import

desc BAJAJ_AUTO;
desc EICHER_MOTORS;
desc HERO_MOTORCORP;
desc INFOSYS;
desc TCS;
desc TVS_MOTORS;

-- Creating table Bajaj1 containing the date, close price, Twenty_Day_MA and Fifty_Day_MA

create table bajaj1
as
SELECT Bajaj_Auto_date, Close_Price,
avg(Close_Price) over (order by Bajaj_Auto_date rows between 19 preceding and current row) as Twenty_Day_MA,
avg(Close_Price) over (order by Bajaj_Auto_date rows between 49 preceding and current row) as Fifty_Day_MA
FROM Bajaj_Auto;

-- Creating table Eicher1 containing the date, close price, Twenty_Day_MA and Fifty_Day_MA

create table eicher1
as
SELECT Eicher_Motor_date, Close_Price,
avg(Close_Price) over (order by Eicher_Motor_date rows between 19 preceding and current row) as Twenty_Day_MA,
avg(Close_Price) over (order by Eicher_Motor_date rows between 49 preceding and current row) as Fifty_Day_MA
FROM Eicher_Motors;

-- Creating table hero1 containing the date, close price, Twenty_Day_MA and Fifty_Day_MA

create table hero1
as
SELECT Hero_Motorcorp_date, Close_Price,
avg(Close_Price) over (order by Hero_Motorcorp_date rows between 19 preceding and current row) as Twenty_Day_MA,
avg(Close_Price) over (order by Hero_Motorcorp_date rows between 49 preceding and current row) as Fifty_Day_MA
FROM Hero_Motorcorp;

-- Creating table infosys1 containing the date, close price, Twenty_Day_MA and Fifty_Day_MA

create table infosys1
as
SELECT Infosys_date, Close_Price,
avg(Close_Price) over (order by Infosys_date rows between 19 preceding and current row) as Twenty_Day_MA,
avg(Close_Price) over (order by Infosys_date rows between 49 preceding and current row) as Fifty_Day_MA
FROM Infosys;

-- Creating table tcs1 containing the date, close price, Twenty_Day_MA and Fifty_Day_MA

create table tcs1
as
SELECT TCS_date, Close_Price,
avg(Close_Price) over (order by TCS_date rows between 19 preceding and current row) as Twenty_Day_MA,
avg(Close_Price) over (order by TCS_date rows between 49 preceding and current row) as Fifty_Day_MA
FROM TCS;

-- Creating table tvs1 containing the date, close price, Twenty_Day_MA and Fifty_Day_MA

create table tvs1
as
SELECT TVS_Motors_date, Close_Price,
avg(Close_Price) over (order by TVS_Motors_date rows between 19 preceding and current row) as Twenty_Day_MA,
avg(Close_Price) over (order by TVS_Motors_date rows between 49 preceding and current row) as Fifty_Day_MA
FROM TVS_Motors;

-- Creating master_table containing the date and close price of all the six stocks

create table master_table as 

select b.Bajaj_Auto_date as The_date, 
b.Close_Price as Bajaj_Close_Price, 
tc.Close_Price as TCS_Close_Price, 
tv.Close_Price as TVS_Close_Price, 
i.Close_Price as Infosys_Close_Price, 
e.Close_Price as Eicher_Close_Price, 
h.Close_Price as Hero_Close_Price 
from bajaj1 b 
inner join tcs1 tc on tc.tcs_date = b.Bajaj_Auto_date
inner join tvs1 tv on tv.tvs_motors_date = tc.tcs_date
inner join infosys1 i on i.infosys_date = tv.tvs_motors_date
inner join eicher1 e on e.eicher_motor_date = i.infosys_date
inner join hero1 h on h.hero_motorcorp_date = e.eicher_motor_date;

-- Using bajaj1 create bajaj2 to generate buy and sell signal in column Signal

create table bajaj2 as
 select Bajaj_Auto_date,Close_price,
 case 
 when fifty_day_MA is NULL then 'NA'
 when twenty_day_MA>fifty_day_MA and ((lag(twenty_day_MA,1) over(order by Bajaj_Auto_date))<(lag(fifty_day_MA,1) over(order by Bajaj_Auto_date))) then 'BUY'
 when twenty_day_MA<fifty_day_MA and ((lag(twenty_day_MA,1) over(order by Bajaj_Auto_date))>(lag(fifty_day_MA,1) over(order by Bajaj_Auto_date))) then 'SELL'
 else 'HOLD' 
 end as Signal
  from bajaj1 ;
  
-- create table eicher2 
create table eicher2 as
select eicher_motor_date,close_price,
 case 
 when fifty_day_MA is NULL then 'NA'
 when twenty_day_MA>fifty_day_MA and ((lag(twenty_day_MA,1) over(order by eicher_motor_date))<(lag(fifty_day_MA,1) over(order by eicher_motor_date))) then 'BUY'
 when twenty_day_MA<fifty_day_MA and ((lag(twenty_day_MA,1) over(order by eicher_motor_date))>(lag(fifty_day_MA,1) over(order by eicher_motor_date))) then 'SELL'
 else 'HOLD' 
 end as Signal
  from eicher1 ;
  
-- create table tcs2 
create table tcs2 as
select tcs_date,close_price,
 case 
 when fifty_day_MA is NULL then 'NA'
 when twenty_day_MA>fifty_day_MA and ((lag(twenty_day_MA,1) over(order by tcs_date))<(lag(fifty_day_MA,1) over(order by tcs_date))) then 'BUY'
 when twenty_day_MA<fifty_day_MA and ((lag(twenty_day_MA,1) over(order by tcs_date))>(lag(fifty_day_MA,1) over(order by tcs_date))) then 'SELL'
 else 'HOLD' 
 end as Signal
  from tcs1 ;
  
  -- create table tvs2 
create table tvs2 as
select tvs_motors_date,close_price,
 case 
 when fifty_day_MA is NULL then 'NA'
 when twenty_day_MA>fifty_day_MA and ((lag(twenty_day_MA,1) over(order by tvs_motors_date))<(lag(fifty_day_MA,1) over(order by tvs_motors_date))) then 'BUY'
 when twenty_day_MA<fifty_day_MA and ((lag(twenty_day_MA,1) over(order by tvs_motors_date))>(lag(fifty_day_MA,1) over(order by tvs_motors_date))) then 'SELL'
 else 'HOLD' 
 end as Signal
  from tvs1 ;
  
  -- create table hero2 
create table hero2 as
select hero_motorcorp_date,close_price,
 case 
 when fifty_day_MA is NULL then 'NA'
 when twenty_day_MA>fifty_day_MA and ((lag(twenty_day_MA,1) over(order by hero_motorcorp_date))<(lag(fifty_day_MA,1) over(order by hero_motorcorp_date))) then 'BUY'
 when twenty_day_MA<fifty_day_MA and ((lag(twenty_day_MA,1) over(order by hero_motorcorp_date))>(lag(fifty_day_MA,1) over(order by hero_motorcorp_date))) then 'SELL'
 else 'HOLD' 
 end as Signal
  from hero1 ;

 -- create table infosys2 
create table infosys2 as
select infosys_date,close_price,
 case 
 when fifty_day_MA is NULL then 'NA'
 when twenty_day_MA>fifty_day_MA and ((lag(twenty_day_MA,1) over(order by infosys_date))<(lag(fifty_day_MA,1) over(order by infosys_date))) then 'BUY'
 when twenty_day_MA<fifty_day_MA and ((lag(twenty_day_MA,1) over(order by infosys_date))>(lag(fifty_day_MA,1) over(order by infosys_date))) then 'SELL'
 else 'HOLD' 
 end as Signal
  from infosys1 ;
  
 -- Checking Data
 
 select * from bajaj2;
 select * from eicher2;
 select * from hero2;
 select * from infosys2;
 select * from tcs2;
 select * from tvs2;
 
 -- Task 3 :Start
 
CREATE FUNCTION get_signal(signal_date date)
   RETURN varchar
   IS signal_detail varchar(20);
   BEGIN 
      select Signal into signal_detail from bajaj2 where bajaj2.bajaj_auto_date = signal_date;
	return(signal_detail); 
    END;
    
 -- testing of function 
  select get_signal('21-JUN-18') from dual;
 -- Expected output  BUY , actual output BUY ->Pass 
 select get_signal('29-MAY-18') from dual;
  -- Expected output SELL, actual output SELL ->Pass
 select get_signal('30-MAY-18') from dual;
 -- Expected output HOLD, actual output HOLD ->Pass

--Let's watch the trend to understand during weekdays and weekends

 select CLOSE_PRICE, SIGNAL, BAJAJ_AUTO_DATE, TO_CHAR(Bajaj_Auto_date , 'DAY') from bajaj2 where Signal='BUY' or Signal='SELL';

 select CLOSE_PRICE, SIGNAL, EICHER_MOTOR_DATE, TO_CHAR(Eicher_Motor_date , 'DAY') from Eicher2 where Signal='BUY' or Signal='SELL';
 
select CLOSE_PRICE, SIGNAL, Hero_Motorcorp_date, TO_CHAR(Hero_Motorcorp_date , 'DAY') from Hero2 where Signal='BUY' or Signal='SELL';

select CLOSE_PRICE, SIGNAL, Infosys_Date, TO_CHAR(Infosys_Date , 'DAY') from Infosys2 where Signal='BUY' or Signal='SELL';

select CLOSE_PRICE, SIGNAL, tcs_date, TO_CHAR(tcs_date , 'DAY') from tcs2 where Signal='BUY' or Signal='SELL';

select CLOSE_PRICE, SIGNAL, tvs_motors_date, TO_CHAR(tvs_motors_date , 'DAY') from tvs2 where Signal='BUY' or Signal='SELL';
 
 -- Getting the trend
 select Close_price from bajaj_auto  order by bajaj_auto_date desc fetch first row only;
 
 select (select Close_price from bajaj_auto  order by bajaj_auto_date desc fetch first row only) 
 - (select Close_price from bajaj_auto  order by bajaj_auto_date  fetch first row only) a
 select (select Close_price from tcs  order by tcs_date desc fetch first row only) 
 - (select Close_price from tcs  order by tcs_date  fetch first row only) as Trend from dual;
 
select (select Close_price from eicher_motors  order by eicher_motor_date desc fs Trend from dual;
 etch first row only) 
 - (select Close_price from eicher_motors  order by eicher_motor_date  fetch first row only) as Trend from dual;
 
select (select Close_price from tvs_motors  order by tvs_motors_date desc fetch first row only) 
 - (select Close_price from tvs_motors  order by tvs_motors_date  fetch first row only) as Trend from dual;
 
select (select Close_price from infosys  order by infosys_date desc fetch first row only) 
 - (select Close_price from infosys  order by infosys_date  fetch first row only) as Trend from dual;

--Drop off the temporary tables post this. This part of code is not written, but dropped in local
 
 