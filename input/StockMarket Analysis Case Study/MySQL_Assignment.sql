
############### Importing file using the Import wizard of MySQL workbench ############
use assignment;
set SQL_SAFE_UPDATES = 0;

############## Describe the data types of variables in the repective company table #############
desc `bajaj auto`;
desc `eicher motors`;
desc `hero motocorp`;
desc `infosys`;
desc `tcs`;
desc `tvs motors`;

######### Creating temporary tables to convert Date variable to date format so that it could be sorted and fetch Close Price ########
create table bajajtemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `bajaj auto`; 
create table eichertemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `eicher motors`;
create table herotemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `hero motocorp`;
create table infosystemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `infosys`;
create table tcstemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `tcs`;
create table tvstemp select str_to_date(Date,'%d-%M-%Y') Date,`Close Price` from `tvs motors`;

################################################################################################
################## 1 Calculating the 20 and 50 Days Moving Average #############################
################################################################################################