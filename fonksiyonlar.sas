/* FONKSİYONLAR */

* 3 kolondan oluşan bir tablo oluşturuyoruz.;
data work.ornek_tablo;
set sashelp.baseball(keep= Team Salary nAtBat);
rename Team = Takim;
rename Salary = Maas;
rename nAtBat = Deger;
run;

* Nümerik Fonksiyonlar;

/* SUM (Toplama-Çıkarma) */
data work.ornek_tablo2;
set work.ornek_tablo;
Maas_Deger = sum(Maas,Deger);
Maas_Deger_Cikar = sum(Maas, -Deger);
run;

* If örnekli kullanım;
data work.ornek_tablo2;
set work.ornek_tablo;
Maas_Deger = sum(Maas,Deger);
if Maas ne . then Maas_Deger_Cikar = sum(Maas, -Deger);
if Maas_Deger_Cikar < 0 then Maas_Deger_Cikar = 0;
run;

/* Min-Max-Divide Kullanımı */
data work.ornek_tablo2;
set work.ornek_tablo;
Maas_Deger = sum(Maas,Deger);
if Maas ne . then Maas_Deger_Cikar = sum(Maas, -Deger);
if Maas_Deger_Cikar < 0 then Maas_Deger_Cikar = 0;

Minumum = min(Maas, Deger);
Maksimum = max(Maas, Deger);
Maas_Yuzde = divide(Maas, 100);
run;


* Karakter Fonksiyonlar;

/* catx() fonksiyonu iki veya daha fazla kelimeyi birleştirmeye yaramaktadır. catx() içerisine 
birleştirmenin nasıl yapılacağını ve hangi kısımların kullanıcılacağı belirtilmektedir.
*/

data work.ornek_tablo3;
set work.ornek_tablo;
Takim_Adlari = catx("_","Takim",Takim);
Tum_Veri = catx(" ", Takim, Maas, Deger);
run;

/* substr() fonksiyonu bir karakter alanı içindeki belli bir alanı almaya yaramaktadır. 
İlk olarak hangi alanda işlem yapılacağını sonra ise seçilecek alanın hangi karakterden
başlayıp nerde biteceği belirtilmektedir. */

data work.ornek_tablo3;
set work.ornek_tablo;
Takim_Kisaltmasi = substr(Takim,1,3);
run;

*******************************************************************;

data work.ornek_tablo3;
set work.ornek_tablo;
Takim_Adlari = catx(":","Takim",Takim);
Yeni_Takim = substr(Takim_Adlari,7);
run;


* Karakter-Nümerik Çevirme Fonksiyonları;

/* put: Nümerik bir alanı karakter yapmaya, input: karakter olan bir alanı nümerik
yapmaya yaramaktadır.
*/

data work.ornek_tablo4;
set work.ornek_tablo;
Maas_Character = put(Maas, 8.2);
Maas_Numeric = input(Maas_Character,8.);
run;

/* Yukarıdaki alanda put içerisine nümerikten karaktere, input içerisine  karakterden nümeriğe
çevireceğimiz alanı, kaç karakter olacağını ve . ifadesinden sonra ilave olarak kaç karakter
daha gösterileceğini belirtiyoruz.
*/


* Tarih Fonksiyonları;

data work.tarih_tablosu;
Tarih = '01JAN2020';

Tarih_Numeric = input(Tarih,date9.);
format Tarih_Numeric date9.;
format Tarih_Numeric ddmmyy10.;
format Tarih_Numeric ddmmyyp10.;

run;

/* Şimdi öncelikle tarih alanı ile ilgili bir işlem yapabilmek için alanın tarih formatında olması
gerekmektedir.Tarih formatı dediğimiz ise SAS'taki nümerik formattır.Bu yüzden karakter olan alanı
input fonksiyonu ile nümeriğe çevirmemiz gerekmektedir.Çevirme işleminden sonra sonuç bize nümerik
olarak arka planda bir değer göstericektir.Bu değeri biz görüntülerken format fonksiyonu ve 
farklı tarih dönüşümleri kullanarak tarihe çevireceğiz.
*/


* intnx: Gün,Ay,Yıl Eklemesi ve Çıkarması;

data work.tarih_tablosu;
Tarih = '01JAN2020';
Tarih_Nm = input(Tarih,date9.);
format Tarih_Nm ddmmyyp10.;

Tarih_Ekleme = intnx('month',Tarih_Nm,1);
format Tarih_Ekleme ddmmyyp10.;

Tarih_Cikarma = intnx('month',Tarih_Nm,-3);
format Tarih_Cikarma ddmmyyp10.;


* intck : İki Tarih Arası Çıkarma;

data work.tarih_tablosu;
Tarih = '01JAN2020';
Tarih_Nm = input(Tarih,date9.);
format Tarih_Nm ddmmyyp10.;

Tarih_Ekleme = intnx('month',Tarih_Nm,1);
format Tarih_Ekleme ddmmyyp10.;

Tarih_Cikarma = intnx('month',Tarih_Nm,-3);
format Tarih_Cikarma ddmmyyp10.;

Tarih_Fark = intck('day',Tarih_Ekleme,Tarih_Cikarma);

run;


