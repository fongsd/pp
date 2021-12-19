select distinct d.indeks, ocena, mestorodjenja
from da.dosije d join da.ispit i
on d.indeks = i.indeks
where mestorodjenja like 'Beograd%' 
and (ocena <> 10 and ocena > 5 and status = 'o')
order by 2;

select indeks, idpredmeta, case when ocena = 6 then 'sest' when ocena = 7 then 'sedam'
	when ocena = 8 then 'osam'
	when ocena = 9 then 'devet'
	when ocena = 10 then 'deset'
end , ocena
from da.ispit 
where ocena > 5 and status = 'o';

select naziv, espb, case when espb >= 15 then 'I' when espb between 10 and 15 then 'II' else 'III' end
from da.predmet;

values dayofweek('14.12.2021');

values dayofyear(current date);
values week(current date);
values dayofweek(current date);
values dayname(current date);
values monthname(current date);

select current user, current schema
from sysibm.sysdummy1;

values second(current time);

values date('11.11.2008') - date('6.8.2005');

values current date + 12 years + 5 months + 25 days;

select idpredmeta, datpolaganja
from da.ispit
where datpolaganja >date('28.09.2020');

values day(current date);

select *
from da.ispit 
where datpolaganja >= current date - 8 months and datpolaganja is not null;

select *
from da.ispit
where  datpolaganja is not null
order by datpolaganja desc
;

select indeks, ocena, idpredmeta, year(current date - datpolaganja), month(current date - datpolaganja),
day(current date - datpolaganja), datpolaganja
from da.ispit
where year(datpolaganja) >= year(current date - 3 years); 

select d.indeks, ime, prezime, case when mestorodjenja like 'Beograd%' then 'Bg' else mestorodjenja end, substr(ime, 1,1) || ',' || substr(prezime, 1,1)
from da.dosije d;

select indeks, naziv, case when ocena = 6 then '-1' else ocena end
from da.ispit i join da.predmet p 
on i.idpredmeta = p.id 
and ocena > 5 and status = 'o'
order by 3;

select ceil(decimal(espb * 1.2, 3, 1))
from da.predmet
where espb * 1.2 >= 8.0;

select i.indeks, idpredmeta
from da.ispit i
where i.ocena = 10 and i.status = 'o'
and not exists (select *
				from da.ispit i2
				where i2.idpredmeta = i.idpredmeta
				and i2.ocena = 10 and i2.status = 'o'
				and i2.indeks <> i.indeks);

select ocena 
from da.ispit 
where idpredmeta = 1594
and ocena is not null
order by ocena desc;

select substr(indeks,5) || '/' ||substr(indeks,1,4), naziv, p.id
from da.ispit i join da.predmet p on p.id=i.idpredmeta
where ocena=10 and status='o' and not exists (select *
                                             from da.ispit i2
                                             where i2.indeks<>i.indeks 
                                              and ocena=10 and status='o' and
                                              i.idpredmeta=i2.idpredmeta);
                                               
select distinct coalesce(dayname(date(i.datpolaganja)), 'nije bilo'), naziv
from da.ISPITNIROK ir left join da.ispit i
on ir.oznakaroka = i.oznakaroka and ir.skgodina = i.skgodina
where ir.skgodina between 2000 and 2020
order by 1 desc;

select ime, prezime, datupisa
from da.dosije d
where exists(select *
			 from da.dosije d1
			 where d1.mestorodjenja = d.mestorodjenja
			 and d1.datupisa + 1 year = d.datupisa);

select case when ime is null then 'nema' else ime || ' ' || prezime end student, naziv
from da.dosije d left join da.ispit i
on d.indeks = i.indeks
join da.predmet p
on p.id = i.idpredmeta
where skgodina = 2022;

select naziv
from da.ispitnirok ir join da.ispit i
on ir.oznakaroka = i.oznakaroka 
and ir.skgodina = i.skgodina
join da.dosije d
on d.indeks = i.indeks
where exists(select *
			from da.ispit i1
			where i1.indeks  = d.indeks
			and i1.status = 'o' and i1.ocena = 10);









