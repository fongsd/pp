select count 
from da.dosije;

select count 
from da.dosije d
where exists(
	select *
	from da.ispit i 
	where i.ocena = 10 and i.status = 'o'
	and d.indeks = i.indeks);
	
select count, sum(espb)
from da.ispit i join da.predmet p
on i.idpredmeta = p.id
where indeks = 20160025 and ocena > 5 and status = 'o'
group by indeks;

select distinct nullif(ocena, 5)
from da.ispit;

select count( distinct  ocena)
from da.ispit 
where ocena <> 5;

select oznaka, naziv, espb
from da.predmet 
where espb >= (select avg(espb * 1.0) from da.predmet);

select d.indeks, avg(ocena * 1.0), min(ocena), max(ocena)
from da.dosije d join da.ispit i
on d.indeks = i.indeks
where ocena > 5 and status = 'o' and 
year(datupisa) = 2018
and exists(select *
		  from da.ispit i
		  where i.indeks = d.indeks
		  and ocena > 5 and status = 'o')
group by d.indeks
;

select naziv, i.skgodina, max(ocena)
from da.ispit i right join da.predmet ir
on i.idpredmeta = ir.id
group by naziv, i.skgodina;

select count, idpredmeta
from da.ispit 
where ocena > 5 and status = 'o'
group by idpredmeta;

select idpredmeta, count( distinct indeks)
from da.ispit 
group by idpredmeta
having count(distinct indeks) >= 50;

select oznakaroka, count(distinct indeks), count 
from da.ispit 
where status = 'o'
group by oznakaroka, skgodina
having skgodina = 2016 and min(ocena) > 5;


select indeks, monthname(datpolaganja), count
from da.ispit 
where ocena > 5 and status = 'o'
group by indeks, datpolaganja
having count  >= 2
order by 3 desc;

select naziv, coalesce(ime || ' ' || prezime, 'nema'), espb
from da.predmet d left  join da.ispit i
on d.id = i.idpredmeta
and ocena > 5 and status = 'o'
left join da.dosije p
on p.indeks = i.indeks
where espb = (select min(espb) from da.predmet);

select naziv,  coalesce(ime || ' ' || prezime, 'nema')
from da.predmet p left join da.ispit i on id=idpredmeta
        and ocena>5 and status='o'
     left join da.dosije d 
       on d.indeks=i.indeks 
where espb = (select min(espb)
              from da.predmet);

