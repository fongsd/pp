select *
from da.predmet
order by espb asc;

select oznaka, naziv, obimespb/60 godine
from da.studijskiprogram
where obimespb/60>=3
order by godine;

select *
from da.dosije 
where datdiplomiranja is null;

select *
from da.dosije 
where datdiplomiranja is not null;


--select *
--from da.dosije, da.ispit
--order by 1;

select *
from da.dosije d left join da.ispit i
on d.indeks = i.indeks
where d.indeks = 20150323;

select d.indeks, ime, prezime, idpredmeta, ocena, datpolaganja
from da.dosije d,da.ispit i
where d.indeks = i.indeks 
and i.datpolaganja = '28.1.2016';


select d.indeks, ime, prezime, p.id, p.naziv, ocena
from da.dosije d left join da.ispit i
on d.indeks = i.indeks
join da.predmet p
on i.idpredmeta = p.id
where status = 'o' and ocena > 5;

select *
from da.dosije d 
where exists( select *
			 from da.ispit i
			 where i.datpolaganja = d.datdiplomiranja);

select *
from da.predmet p1, da.predmet p2
where p1.espb = p2.espb 
and p1.id < p2.id;

select d.indeks, ime, prezime, datpolaganja, ocena, espb
from da.dosije d
join da.ispit i
on d.indeks = i.indeks
join da.predmet p
on i.idpredmeta = p.id 
where d.prezime like '___a%' and d.prezime like '%c'
and espb between 2 and 10
and ocena in (6,8,10)
and status = 'o'
and datpolaganja between date('5.01.2018') and ('15.12.2018');


select pp.idpredmeta, iduslovnogpredmeta, vrsta, pp.idprograma
from da.predmetprograma pp left join da.uslovnipredmet up
on pp.idpredmeta = up.idpredmeta
and pp.idprograma = up.idprograma
order by 1;

select p1.naziv, p2.naziv, up.idpredmeta, up.iduslovnogpredmeta, idprograma
from da.uslovnipredmet up left join da.predmet p1
on p1.id = up.idpredmeta
left join da.predmet p2
on p2.id = up.iduslovnogpredmeta
order by 1;

select *
from da.predmet 
where id = 2357;


select *
from da.dosije d, da.ispitnirok is
where d.datdiplomiranja = is.datkraja
union 
select *
from da.dosije d, da.ispitnirok is
where d.datdiplomiranja is null or is.datkraja is null;


select indeks, ime, prezime, datdiplomiranja, naziv, datkraja
from da.dosije d full join da.ispitnirok is 
on datdiplomiranja = datkraja;

select *
from da.ispitnirok
where datkraja = '09.12.2019';


select ime, prezime, ocena, oznakaroka, skgodina
from da.dosije d left join da.ispit i
on d.indeks = i.indeks
and ime = 'Jovana' and prezime = 'Lukic'
order by d.indeks;

select distinct ime, prezime, naziv, ocena, status
from da.dosije d left join da.ispit i
on d.indeks = i.indeks 
join da.predmet p on i.idpredmeta = p.id
where lower(ime) like '%ark%'
and ocena is null or (ocena > 5 and status = 'o')
order by 4 asc;

select p1.* , p2.*
from da.dosije p1 join da.dosije p2
on p1.mestorodjenja = p2.mestorodjenja
and p1.indeks < p2.indeks;

select distinct p.naziv, skgodina, oznakaroka
from da.ispit i left join da.predmet p
on i.idpredmeta = p.id
where status = 'p' or status <> 'p'
order by 2 desc, 3 desc;

select *
from da.predmet p
where not exists ( 
			select *
			from da.ispit i
			where i.idpredmeta = p.id
			and i.status <> 'p');

select ime, prezime, d.indeks, espb, naziv, skgodina
from da.dosije d join da.upisankurs uk
on d.indeks = uk.indeks
join da.predmet p 
on p.id = uk.idpredmeta
where p.espb in (5, 10, 12, 25)
and naziv like 'Pr%o%'
and skgodina between 2016 and 2020
order by 3;













