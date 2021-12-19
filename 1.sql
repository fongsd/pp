select *
from da.predmet;

select *
from da.dosije
where mestorodjenja like 'Beograd%';

select distinct mestorodjenja
from da.dosije;

select naziv
from da.predmet
where espb = 6;

select idpredmeta, naziv 
from da.predmet 
where espb between 8 and 15;

select *
from da.ispitnirok
where skgodina in (2015, 2016, 2018);

select *
from da.ispitnirok
where skgodina not in (2015, 2016, 2018);

select *
from da.dosije
where indeks/10000 = 2015;

select naziv, espb * 2000 cena
from da.predmet;

select naziv, 'cena' din, espb * 2000 cena
from da.predmet;

select *
from da.dosije
where mestorodjenja like '%o%';

select *
from da.dosije
where mestorodjenja like '_o%';

select *
from da.dosije
where mestorodjenja like '%e';

select *
from da.dosije
where mestorodjenja like 'N%d';

select *
from da.predmet
order by espb;

select *
from da.predmet
order by espb desc; 

select *
from da.predmet
order by espb, naziv desc; 

select ime, prezime, datupisa
from da.dosije
where datupisa between date('10.07.2017') and date ('15.9.2017');

select *
from da.studijskiprogram
where obimespb/60.0 >= 3
order by obimespb;

select ime, prezime, indeks
from da.dosije;

select distinct espb
from da.predmet;

select distinct ime
from da.dosije
where pol = 'z';

select *
from da.ispit 
where oznakaroka = 'jan1' and poeni = 100;

select indeks
from da.ispit 
where poeni between 65 and 87;

select indeks student, year(datupisa) godupisa
from da.dosije
where year(datupisa) not in (2013, 2016);

select ime, prezime 
from da.dosije 
where ime not in ('Marko', 'Veljko', 'Ana')
order by 2 desc, 1 asc;





