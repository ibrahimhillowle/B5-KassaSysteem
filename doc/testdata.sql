-- create user kassagebruiker identified by 'Assak_dnalrepoleveD';
-- -- grant usage on developerland_kassa.* to 'kassagebruiker'@'localhost';

use developerland_kassa;
set FOREIGN_KEY_CHECKS = 0;

truncate table product_categorieen;
insert into product_categorieen(categorie_id, naam, beschrijving, is_actief)
values  (1, 'test', 'test categorie', true),
		(2, 'non-alcoholische koude dranken', 'non-alcoholische frisdranken', true),
        (3, 'non-alcoholische warme dranken', 'warme dranken zoals koffie, thee', true),
        (4, 'alcoholische koude dranken', 'alcohol bevattende koude dranken zoals bier, whiskey, wijn', true),
        (5, 'voorgerechten', 'kleine voorgerechten', true),
        (6, 'hoofdgerechten', 'hoofd maaltijden', true),
        (7, 'nagerechten', 'kleine gerechten, desserts, etc', true);
truncate table producten;
insert into producten(naam, categorie_id, beschrijving, stuksprijs, is_actief) 
values ('test naam', 1, 'test omschrijving', 10.99, true),
	('cola', 2, 'glas cola', 1.50, true),
    ('bruisend water', 2, 'glas bruisend water', 1.00, true),
	('koffie', 3, 'kopje koffie, naar wens met melk en/of suiker', 2.50, true),
    ('thee', 3, 'mok thee, naar wens met suiker', 2.50, true),
    ('chocomel', 3, 'mok chocomel', 3.00, true),
    ('grolsch bier', 4, 'fles grolsch bier', 3.00, true),
    ('tapas', 5, 'borde tapas hapjes', 5.00, true),
    ('zalm gerecht', 6, 'stuk zalm met brocolli en frites', 9.99, true),
    ('biefstuk', 6, 'biefstuk met spinazie en gebakken aardappeltjes', 12.50, true),
    ('appeltaart', 7, 'stukje appeltaart', 3.50, true),
    ('slagroomtaart', 7, 'stukje slagroomtaart', 3.90, true);

truncate table rollen;
insert into rollen(rol_id, naam, beschrijving, is_actief)
			select 1, 'klant', 'de klant', true
union all 	select 2, 'cassiere', 'kassa medewerk(st)er', true
union all 	select 3, 'beheerder', 'superuser met gebruikers beheer', true;

truncate table gebruikers;
insert into gebruikers(gebruikersnaam, volledige_naam, pincode, wachtwoord, is_actief, rol_id)
			select 'tester', 'test gebruiker', sha2('0000', 256), null, true, 3
union all 	select 'karin', 'Karin de Lie', sha2('1234', 256), null, true, 2
union all 	select 'anne', 'Anne Boers', sha2('4321', 256), null, true, 2
union all 	select 'ali', 'Ali Roers', sha2('2233', 256), null, true, 2
union all 	select 'beheerder', 'Beheerder', sha2('4321', 256), null, true, 3;

truncate table config;
insert into config(`key`, `value`)
select 'pincode_length', '4'
union all select 'bevestig_afsluiten', 'true';

set FOREIGN_KEY_CHECKS = 1;