create database if not exists developerland_kassa;
use developerland_kassa;
set FOREIGN_KEY_CHECKS = 0;
drop table if exists product_categorieen;
create table product_categorieen(
	categorie_id int primary key auto_increment,
	naam varchar(255) not null,
	beschrijving varchar(512) null,
	is_actief int(1) not null default true
);

drop table if exists producten;
create table producten(
	product_id int primary key auto_increment,
	categorie_id int not null,
	naam varchar(255) not null,
	beschrijving varchar(512) null,
	stuksprijs decimal(14,2) null,
	is_actief int(1) not null default true,
	constraint `fk_product_categorie` 
		foreign key (categorie_id) references product_categorieen(categorie_id) 
		on update restrict on delete cascade
);

drop table if exists soortkortingen;
create table soortkortingen(
	soortkorting_id int primary key auto_increment,
    naam varchar(255),
    beschrijving varchar(512) null,
    is_actief int(1) not null default true
);

drop table if exists kortingen;
create table kortingen(
	korting_id int primary key auto_increment,
    soortkorting_id int,
    naam varchar(255) not null,
    beschrijving varchar(512) null,
    multiplier decimal(4,2) null,
    fixed_value decimal(6,2) null,
	geldig_van date not null,
    geldig_tot date not null,
    is_actief int(1) not null default true,
    constraint `fk_korting_soortkorting`
		foreign key (soortkorting_id) references soortkortingen(soortkorting_id)
        on update restrict on delete cascade
);

-- alter table if exists gebruikers drop contraint fk_gebruiker_rol;
drop table if exists rollen;
create table rollen(
	rol_id int primary key auto_increment,
    naam varchar(255) not null,
    beschrijving varchar(512) null,
    is_actief int(1) not null default true
);

drop table if exists gebruikers;
create table gebruikers(
	gebruiker_id int primary key auto_increment,
	rol_id int not null,
	gebruikersnaam varchar(255) not null,
	volledige_naam varchar(255) null,
	pincode varchar(256), /* sha256 hash */
	wachtwoord varchar(512) null, /* TODO: hasing */
	is_actief int(1) not null default true,
	constraint `fk_gebruiker_rol`
		foreign key (rol_id) references rollen(rol_id)
		on update restrict
);

drop table if exists config;
create table config(
	`key` varchar(50) not null,
	`value` varchar(2048) null
);

drop user if exists kassagebruiker;
drop user if exists kassagebruiker@localhost;
create user kassagebruiker identified by 'Assak_dnalrepoleveD';
create user kassagebruiker@localhost identified by 'Assak_dnalrepoleveD';
grant select, insert, update, delete on developerland_kassa.* to kassagebruiker;
grant select, insert, update, delete on developerland_kassa.* to kassagebruiker@localhost;

set FOREIGN_KEY_CHECKS = 1;
