* Join İşlemleri ;

/* Farklı tabloları ortak bir kolon kullanarak birleştirmemize yaramaktadır. 
Ana olarak 4 join türü bulunmaktadır.
Inner Join : İki tabloda ortak olan alanları yani kesişimini getirmektedir.
Full Join : Tablolardaki tüm değerleri birleştirerek getirmektedir.
left Join : Hangi tabloyu sol tarafa koyup baz alıyorsak öncelikli olarak onları getirmektedir.
Right Join : Sağ taraftaki olan tablonun tüm değerlerini getirmektedir.Sol taraftaki tabloda ne olduğu önemli değildir.
*/


* SQL ile Inner Join İşlemleri ;

proc sql;
create table sql_inner_join as
select t1.DATE, t1.AMOUNT as amount1, t2.AMOUNT as amount 2
from sashelp.nvst1 t1
inner join sashelp.nvst2 t2 on (t1.DATE = t2.DATE);
quit;


* SQL ile Left-Right Join;

* LEFT JOIN;

proc sql;
create table sql_left_join as
select t1.Date,t1.Amount as Amount1, t2.Amount as Amount2
from sashelp.nvst1 t1
left join sashelp.nvst2 t2 on (t1.DATE = t2.DATE);
quit;

/* Farklı anlamak için değeri 5'ten küçük bir tablo oluşturuyoruz.*/
data work.nvst2;
set sashelp.nvst2;
if _N_<5;
run;

proc sql;
create table sql_left_join as
select t1.Date,t1.Amount as Amount1, t2.Amount as Amount2
from sashelp.nvst1 t1
left join work.nvst2 t2 on (t1.DATE = t2.DATE);
quit;


* RIGHT JOIN;

proc sql;
create table sql_right_join as
select t1.Date,t1.Amount as Amount1, t2.Amount as Amount2
from sashelp.nvst1 t1
right join work.nvst2 t2 on (t1.DATE = t2.DATE);
quit;


* SQL ile Full-Outer Join İşlemi;

proc sql;
create table sql_full_join as
select t1.DATE, t1.Amount as Amount1, t2.Amount as Amount2
from sashelp.nvst1 t1
full join sashelp.nvst2 t2 on (t1.DATE = t2.DATE);
quit;


/* Örnek Çalışma */

data work.nvst1;
set sashelp.nvst1;
if _N_<3;
run;

data work.nvst2;
set sashelp.nvst2;
if _N_>=3;
run;

proc sql;
create table sql_full_join_ornek as
select t1.DATE as date1, t2.DATE as date2, t1.Amount as Amount1, t2.Amount as Amount2
from work.nvst1 t1
full join work.nvst2 t2 on (t1.DATE = t2.DATE);
quit;



* SAS ile Inner Join İşlemi ;

/* SAS ile birleştirme işlemi yapmak için tabloları sıralamamız gerekmektedir.Aksi halde mutlaka hata verecektir.*/

proc sort data = sashelp.NVST1 out = work.NVST1; by DATE; quit;
proc sort data = sashelp.NVST2 out = work.NVST2; by DATE; quit;

data sas_innerjoin;
merge work.nvst1(in=s1 rename=(Amount = Amount1)
work.nvst2(in=s2 rename=(Amount = Amount2);
by DATE;
if s1 and s2;
run;


* SAS ile Left-Right Join İşlemleri ;

data work.nvst2;
set sashelp.nvst2;
if _N_ <3;
run;

data sas_leftjoin;
merge work.nvst1(in=s1 rename=(Amount = Amount1)
work.nvst2(in=s2 rename=(Amount = Amount2);
by DATE;
if s1;
run;


data sas_rightjoin;
merge work.nvst1(in=s1 rename=(Amount = Amount1)
work.nvst2(in=s2 rename=(Amount = Amount2);
by DATE;
if s2;
run;


* SAS ile Full Join İşlemi ;

data sas_fulljoin;
merge work.nvst1(in=s1 rename=(Amount = Amount1)
work.nvst2(in=s2 rename=(Amount = Amount2);
by DATE;
if s1 or s2;
run;

/*******************************/

/* Aynı kolon isimlerine sahip olan tabloları alt alta eklemek */

data fulltablo;
set sashelp.nvst1
sashelp.nvst2;
run;
