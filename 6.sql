select i1.indeks, i2.indeks
from da.ispit i1, da.ispit i2
where i1.status = 'o' and i2.status = 'o'
and i1.ocena > 5 and i2.ocena > 5
group by i1.indeks, i2.indeks, i1.idpredmeta, i2.idpredmeta;

select d1.indeks, d2.indeks
from da.dosije d1, da.dosije d2
where d1.indeks < d2.indeks and 
	(select count
	from da.ispit i1 join da.ispit i2
	on i1.idpredmeta = i2.idpredmeta
	and i1.skgodina = i2.skgodina
	and i1.oznakaroka = i2.oznakaroka
	where i1.indeks <> i2.indeks
	and i1.status = 'o' and i2.status = 'o'
	and i1.indeks = d1.indeks and d2.indeks = i2.indeks) >= 2
and d1.ime like 'M%' and d2.ime like 'M%';


with st_bod as (
	select indeks, sum(espb) pol
	from da.ispit i join da.predmet p
	on i.idpredmeta = p.id
	where status = 'o' and ocena > 5
	group by indeks, espb
	having sum(espb) >= 10)
select count(distinct indeks)
from st_bod;


with pol as (
	select d.indeks, count(i1.ocena), i1.ocena, i1.status, i2.ocena, i2.status, count(i2.ocena)
	from da.dosije d join da.ispit i1
	on d.indeks = i1.indeks and i1.status = 'o' and i1.ocena = 8
	join da.ispit i2 on 
	d.indeks = i2.indeks
	and i2.ocena = 9 and i2.status = 'o'
	group by d.indeks, i1.ocena, i1.status, i2.ocena, i2.status)
select count( indeks)
from pol;

select indeks, count(case when ocena = 8 and status ='o' then 1 else 0 end) osmice, 
count(case when ocena = 9 and status = 'o' then 1 else 0 end) devetke
from da.ispit 
where status = 'o'
group by indeks
having count(case when ocena = 8 and status ='o' then 1 else 0 end)> 1 and 
count(case when ocena = 9 and status = 'o' then 1 else 0 end) > 1;

select *
from da.ispit 
where ocena = 9 and status = 'o'
and indeks = 20150001;

with student_ocene as (
select indeks, ocena br8, null  br9
from da.ispit
where ocena=8 and status = 'o'
union all
select indeks,  null br8, ocena br9
from da.ispit
where ocena=9 and status = 'o')
select indeks, count(br8) broj_8, count(br9) broj_9
from student_ocene
group by indeks;

select ime, prezime , naziv, status, ocena
from da.dosije d join da.ispit i
on d.indeks = i.indeks
and status = 'o' and ocena > 5
join da.predmet p
on i.idpredmeta = p.id
where not exists (select *
								 from da.ispit i1
								 where i.idpredmeta =i1.idpredmeta
								 and i1.indeks = d.indeks
								 and (i1.oznakaroka <> i.oznakaroka
								 or  i1.skgodina <> i.skgodina)
								 );


select distinct d.indeks, datupisa, coalesce(naziv, repeat('*', length(prezime)))
from da.dosije d left join da.ispit i 
on d.indeks = i.indeks
and status = 'o' and ocena > 5
left join da.predmet p 
on p.id = i.idpredmeta
where datupisa = (select min(datupisa) from da.dosije)
order by 3;

select idpredmeta
from da.ispit
where indeks = 20150002
and status = 'o' and ocena > 5;

select d.indeks, sum(espb) kol
from da.dosije d join da.ispit i
on d.indeks = i.indeks
and status = 'o' and ocena > 5
join da.predmet p 
on p.id = i.idpredmeta
group by d.indeks
having sum(espb) >= all (select sum(espb) kol from da.ispit i1 join da.predmet p1
					 on i1.idpredmeta = p1.id
					 and i1.status = 'o' and i1.ocena > 5
					 group by i1.indeks);

with student as (
	select i.indeks, ir.oznakaroka or, ir.skgodina sk,
	 sum(case when status = 'o' and ocena > 5 then 1 else 0 end) * 1.0/count(distinct idpredmeta) prosek
	 from da.ispit i join da.ispitnirok ir
	 on i.oznakaroka = ir.oznakaroka
	 and i.skgodina = ir.skgodina
	 group by i.indeks, ir.oznakaroka, ir.skgodina
)
select d.indeks, ime, prezime, decimal(st.prosek, 3, 2), st.or, st.sk
from da.dosije d join student st
on d.indeks = st.indeks
where st.prosek <= all (select prosek
					from student st1
					where st1.indeks = d.indeks)
and mestorodjenja = 'Arandjelovac'
and not exists (select *
				from student st2
				where st2.indeks <> d.indeks
				and st2.prosek < st.prosek)
order by d.indeks;
	 
	 
with st as (select ime, ocena, idpredmeta
			from da.dosije d join da.ispit i
			on d.indeks = i.indeks
			and status = 'o' and ocena > 5
			group by ime, ocena, idpredmeta
			order by 1)
select ime, ocena, naziv
from st s join da.predmet p
on p.id = s.idpredmeta
where ocena >= all (select ocena
					from st s1 
					where s.ime = s1.ime
					and s.idpredmeta = s1.idpredmeta)
order by 1;


select naziv
from da.ispitnirok ir
where not exists(
		select *
		from da.ispit i join da.dosije d
		on d.indeks = i.indeks
		where ir.oznakaroka = i.oznakaroka 
		and i.skgodina = ir.skgodina
		and month(d.datupisa) in (11, 12)
		and not exists(
			select *
			from da.dosije d1
			where d1.indeks = i.indeks
			and i.status = 'o' and i.ocena > 5
			and month(d1.datupisa) in (9, 10)
			)
		);

select sp.naziv, d.indeks, ime, prezime, sum(p.espb) 
from da.dosije d join da.studijskiprogram sp
on d.idprograma = sp.id
join da.ispit i on
d.indeks = i.indeks
and status = 'o' and ocena > 5
join da.predmet p 
on i.idpredmeta = p.id
where not exists(
	select sum(p1.espb) from (select *
	from da.dosije d1 join da.ispit i1
	on d1.indeks = i1.indeks
	and status = 'o' and ocena > 5
	join da.predmet p1
	on p1.id = i1.idpredmeta)
	where sum(p1.espb) >= sum(p.espb));

values(abs(-3));

select i.oznakaroka, i1.oznakaroka, abs(i1.datpolaganja - i.datpolaganja) "br dana", naziv, i1.indeks, i.indeks
from da.ispit i, da.ispit i1 join da.predmet p
on i.idpredmeta = p.id
and p.espb between 5 and 10
where i.indeks = i1.indeks
and i.oznakaroka <> i1.oznakaroka
and i.idpredmeta = i1.idpredmeta
and abs(i1.datpolaganja - i.datpolaganja) <= 20
and naziv like '___gr%'
;


select idpredmeta, naziv, d.indeks, ime, prezime, i.oznakaroka
from da.dosije d join da.ispit i
on i.indeks = d.indeks 
join da.predmet p
on p.id = i.idpredmeta
where not exists(
	select *
	from da.ispit i1
	where i1.idpredmeta = i.idpredmeta
	and (i1.oznakaroka <> i.oznakaroka
 	or i1.skgodina <> i.skgodina))
order by 1;

select d1.indeks, d2.indeks, d1.mestorodjenja, d2.mestorodjenja
from da.dosije d1, da.dosije d2
where d1.mestorodjenja = d2.mestorodjenja
and year(d1.datupisa) in (2012, 2015, 2018) 
and year(d2.datupisa) in (2012, 2015, 2018)
and d1.indeks < d2.indeks
and d1.mestorodjenja like '______evo%';


select naziv, ime, prezime, d.indeks, espb, poeni
from da.dosije d join da.ispit i
on d.indeks = i.indeks
and ocena > 5 and status = 'o'
join da.predmet p
on p.id = i.idpredmeta
where 6 * p.espb  = poeni;

select naziv, indeks, poeni
from da.ispit i join da.predmet p
on i.idpredmeta = p.id
and status = 'o'
and ocena > 5
where not exists (
	select *
	from da.ispit i1
	where i.idpredmeta = i1.idpredmeta
	and i.poeni < i1.poeni)
order by idpredmeta;	















