/* If-Else */

/* WORK kütüphanesi içerisine bir tablo tanımlıyoruz ve SASHELP içindeki Baseball veri setini
kullanarak pozisyon ve maaş bilgilerini alarak if ile koşulu belirterek salary2 adında yeni bir kolon
oluşturmasını yapıyoruz. else durumunda ise if şartı sağlanmadığında ki koşulu gerçekleştirir.
Birden fazla if koşuluda kullanabiliriz.
*/

data work.baseball_if;
set SASHELP.baseball(keep= position salary);
if position = 'C' then salary2 = salary + 10;
if position = '1B' then salary2 = salary + 20
else salary2 = salary; 
run;


/* SQL ile If Kullanımı (Case When) */

proc sql;
create table work.baseball_sql as
select position,salary,
case when position = 'C' then salary+10
when position = '1B' then salary+20
else salary end as Salary2
from sashelp.baseball;
quit;

/* SQL'de if durum case-when haline dönüşmektedir.Koşul ifadelerini case ile başlayıp end ile
bitiriyoruz ve koşul durumlarını when sonrasında yazıyoruz.
*/

