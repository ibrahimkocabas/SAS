* TEST adında kütüphane tanımlaması yapılmıştır.;
libname TEST '/folders/myshortcuts/SAS';


* Deneme adında bir tablo oluşturulmuştur;
data work.deneme;
a=5;
run;


/*
TEST klasörü altında DENEME adında bir tablo yarat ve bu tablonun değerlerini
SASHELP altındaki AIR datasından al 
*/

data TEST.deneme_tablo;
set SASHELP.air;
run;

/* Tablo içerisinden eğer belirli bir alanı ya da alanları almak istiyorsak
keep komutunu kullanırız. Almak istediğimiz kolon isimlerini ve aralarında boşluk
bırakarak bu işlemi gerçekleştirebiliriz.Başka bir yolu ise drop komutu kullanarak
alınmasını istemediğimiz kolon isimlerini belirtebiliriz. 

data TEST.deneme_tablo;
set SASHELP.air(keep=DATE AIR);
run;
*/


/* SQL ile Tablo Yaratma */

proc sql;
create table TEST.deneme_tablo2 as
select * from SASHELP.air;
quit;

/* Yıldız ifadesi kullanarak tüm tabloları alırız.Eğer hepsini almak istemiyorsak SELECT ifadesinden
sonra almak istediğimiz kolon isimlerini yazmamız yeterli olacaktır. */



/* Excel Tablosunu SAS Tablosuna Çevirme */

/*
Paylaşılan klasör içerisindeki csv ya da xlsx uzantılı dosya üzerine çift tıklayarak çıkan ekrandan
çalıştırma işlemi yaparak tabloyu SAS içerisine alabiliriz. CODE kısmında çalıştırma kodu bulunmaktadır.
Otomatik olarak WORK klasörü içerisine geçici olarak kaydetmektedir.Kalıcı olarak kullanılmak 
istenilirse Split içerisindeki Output Data kısmından Change diyerek kayıt olacak kütüphane seçimi yapılır.

*/
FILENAME REFFILE '/folders/myshortcuts/SAS/test.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=TEST.ORNEK;
	GETNAMES=YES;
RUN;

/*
Yukaridaki kod bloğunda tanımladığımız paylaşılan dosya klasörü içerisindeki veri setimizin yolunu
belirttikten sonra SAS içerisine import etme işlemini gerçekleşirdik.
DBMS -> Dosya türü uzantısı
OUT -> Çıktı nereye ne isimle yazılacağı
GETNAMES -> YES ise tabloda kolon adları olup olmadığını belirtmektedir.
*/


/* Kolon İsmi Değiştirme */

data TEST.ORNEK2;
set TESt.ORNEK;
rename ID=NUMARA;
run;

/* TEST kütüphanesi içine ORNEK2 adında bir tablo oluştur ve bu tablo verilerini
ORNEK adlı tablodan al ve ID isimli kolonun adını NUMARA olarak değiştir. Rename kısmını yukaridaki
kod harici olarak aşağıdaki örnekte olduğu gibi de yazabiliriz.İstersek de keep komutunu kullanarak bazı
kolon seçimleri de yapabiliriz.

data TEST.ORNEK2;
set TESt.ORNEK(rename = (ID=NUMARA));
keep ADI SOYADI ;
run;

*/


/* Data Step ile Tablo Filtreleme İşlemi */

data work.baseball;
set sashelp.baseball(where = (salary > 250 and nHome > 10 and Position = 'C'));
Maas_zam = Salary + 100;
run;

/* Set içerisine where yazarak istenilen kolon üzerinde belirli bir şarta göre 
filtreleme işlemi yapılır. Birden fazla filtreleme işlemi için AND ya da OR kullanılabilir.
Yeni bir kolon oluşturmak içinse kolon ismi ve başka bir kolon ile birlikte herhangi bir matematiksel
işlem olabilir.
*/


/* SQL ile Tablo Filtreleme */

proc sql;
create table work.baseball2 as
select Position,Salary,Salary+100 as Maas_Zammi from sashelp.baseball
where Position = 'C';
quit;

/* Yukarıdaki kod bloğunda WORK kütüphanesine geçici olarak SASHELP içerisindeki Baseball
veri setini kullanarak bir tablo oluşturduk.İçerisinden poziyon ve maaş kolonlarını seçerek
buna ilave olarak 'Maas_Zammi' adında yeni bir kolon oluşturduk ve where kullanarak bir şart ifadesi
belirterek pozisyonu 'C' olanları aldık. 
*/


/* Tablo Sıralama İşlemleri */

* Maaş ve Takım isimlerinin alındığı bir tablo oluşturma;
data work.baseball_sirasiz;
set sashelp.baseball(keep = Salary Team);
run;

* Artan olacak şekilde sıralama işlemi;
proc sort data=work.baseball_sirasiz;
by Salary;
quit;

* Azalan olacak şekilde sıralama;
proc sort data=work.baseball_sirasiz;
by descending Salary;
quit;

* Tablo üzerinde değişiklik yapmadan başka bir tablo oluşturarak yazma işlemi;
proc sort data=work.baseball_sirasiz out=work.baseball_sirali_maas;
by descending Salary;
quit;

/* Out diyerek tablomuzu nereye kaydedeceğimiz bilgisini ve isim belirtiyoruz */


/* SQL ile Sıralama */

* Takım isimlerine göre sıralı bir tablo oluşturma;
proc sql;
create table work.baseball_sirali_takim as
select * from work.baseball_sirasiz
order by Team;
quit;




