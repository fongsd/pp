select ime, prezime
from da.dosije d 
where exists ( 
	select * 
	from da.ispit i
	where i.indeks = d.indeks 
	and ocena = 9 and status ='o')
order by 1, 2;
	
select distinct ime, prezime
from da.dosije d join da.ispit i
on d.indeks = i.indeks
where ocena = 9 and status = 'o';

select distinct indeks
from da.dosije d
where exists ( 
		select * 
		from da.ispit i
		where i.indeks = d.indeks
		and i.ocena > 5 and status = 'o');
		
select distinct indeks
from da.ispit 
where ocena > 5 and status = 'o'
and idpredmeta not in (select idpredmeta
						from da.ispit
						where indeks = 20170022 and status = 'o'
						and ocena > 5);
	
select naziv 
from da.predmet p 
where exists (
			select *
			from da.ispit i 
			where ocena > 5 and status = 'o'
			and indeks = 20170022
			and p.id = i.idpredmeta);
	
select naziv 
from da.predmet p
where not exists (
		select *
		from da.skolskagodina sk
		where not exists ( 
			select *
			from da.kurs k
			where k.idpredmeta = p.id
			and k.skgodina = sk.skgodina
		));	

select *
from da.predmet p
where not exists (select *
                  from da.SKOLSKAGODINA sg
                  where not exists (select *
                                    from da.kurs k
                                    where k.idpredmeta=p.id
                                          and sg.skgodina=k.skgodina));
                                          
select *
from da.dosije d
where not exists (
			select *
			from da.SKOLSKAGODINA sg
			where not exists (
				select *
				from da.upisgodine ug
				where ug.indeks = d.indeks
				and ug.skgodina = sg.skgodina
			));                                         	
		
select indeks
from da.dosije d 
where not exists (
	select *
	from da.ispitnirok ir
	where not exists(
		select *
		from da.ispit i
		where i.indeks = d.indeks
		and i.oznakaroka = ir.oznakaroka
		and i.skgodina = ir.skgodina
		and status not in ('p', 'n')
	));
	

select *
from da.dosije d
where not exists (
	select *
	from da.ispitnirok ir
	where
	 not exists (
		select *
		from da.ispit i
		where d.indeks = i.indeks 
		and i.status = 'o'
		and i.oznakaroka = ir.oznakaroka
		and i.skgodina = ir.skgodina
	));

select *
from da.predmet p
where p.espb = (select max(espb)
					from da.predmet p1);

select *
from da.dosije d
where d.datdiplomiranja = (select min(datdiplomiranja)
							from da.dosije);


select *
from da.dosije
where datdiplomiranja <= all (select datdiplomiranja
                              from da.dosije
                              where datdiplomiranja is not null);
                              
select *
from da.dosije d
where not datdiplomiranja = (select min(datdiplomiranja)
						from da.dosije);                              
                              
select *
from da.predmet p
where exists (
	select *
	from da.upisankurs i
	where i.idpredmeta = p.id);


select d.indeks, ime, prezime, naziv, i.oznakaroka, i.skgodina
from da.dosije d join da.ispit i
on d.indeks = i.indeks and status = 'o' and ocena > 5
join da.predmet p 
on i.idpredmeta = p.id 
where exists ( select *
			   from da.ispit i1
			   where i1.indeks = d.indeks 
			   and status = 'o'
			   and i1.skgodina = 2018)
and d.indeks = 20150001
order by 1;

select d.indeks, ime, prezime, naziv, skgodina, oznakaroka, ocena
from da.dosije d left join da.ispit i 
		on d.indeks=i.indeks and ocena>5 and status='o'
	 left join da.predmet p 
	    on i.idpredmeta=p.id
where exists (select *
              from da.ispit
              where indeks=d.indeks and skgodina=2018
                     and status not in ('p', 'n'))
and d.indeks = 20150001
order by d.indeks;


select *
from da.predmet p
where not exists (select *
                  from da.dosije d join da.studijskiprogram s
                     on d.idprograma=s.id
                  where mestorodjenja='Berane' and s.oznaka='I' 
                  and not exists (select *
                                  from da.ispit i
                                  where i.indeks=d.indeks 
                                  and i.idpredmeta=p.id
                                  and status not in ('p', 'n') ));


select distinct ime, prezime
from da.dosije d
join da.ispit i
on d.indeks = i.indeks
and status = 'o' and ocena > 5;

select distinct ime, prezime
from da.dosije d
where exists (select *
			  from da.ispit i
			  where d.indeks = i.indeks
			  and status = 'o' and ocena > 5);

select naziv
from da.predmet p
where not exists (
			select *
			from da.dosije d
			where not exists (
			select *
			from da.ispit i
			where d.indeks = i.indeks
			and p.id = i.idpredmeta
			and status = 'o' and ocena >5 ));

select d.indeks, ime, prezime
from da.dosije d
where not exists(	
		select *
		from da.predmet p
		where p.espb = 30
		and not exists(
		select *
		from da.ispit i
		where i.indeks = d.indeks
		and status = 'o'
		and ocena > 5 and p.id = i.idpredmeta));


select d.indeks, ime, prezime, espb, naziv, status, ocena
from da.dosije d join da.ispit i
on d.indeks = i.indeks
join da.predmet p
on p.id = i.idpredmeta
where espb = 30;

select distinct *
from da.predmet
where espb = 30;


select *
from da.ispitnirok 
where datpocetka = (select min(datpocetka)
					from da.ispitnirok);

--select distinct naziv, datpolaganja, ime, prezime, status, ocena
--from da.ispit i join da.predmet p
--on i.idpredmeta = p.id
--and datpolaganja = (select min(datpolaganja) from da.ispit)
-- join da.upisankurs uk
--on i.idpredmeta = uk.idpredmeta
--join da.dosije d
--on uk.indeks = d.indeks;



		