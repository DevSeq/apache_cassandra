create schema if not exists the_business;

create extension if not exists pgcrypto with schema the_business;

create table if not exists the_business.departments
(
    department_id uuid
        default gen_random_uuid()
        not null
        constraint departments_pk
        primary key,
    name          varchar default 150 not null
);

create unique index departments_name_uindex
	on the_business.departments (name);

create table if not exists the_business.employees
(
    employee_id   uuid
        default gen_random_uuid()
        not null
        constraint employees_pk
        primary key,
    first         varchar default 100 not null,
    last          varchar default 100 not null,
    department_id uuid                not null
        constraint employees_departments_fk
        references the_business.departments
        on update cascade on delete set default,
    start         date
        default current_date
        not null
);

create unique index employees_first_last_uindex
	on the_business.employees (first, last);

alter table the_business.departments
    owner to postgres;

alter table the_business.employees
    owner to postgres;

insert into the_business.departments (name) values ('Code');
insert into the_business.departments (name) values ('Metal');
insert into the_business.departments (name) values ('Bikey');

insert into the_business.employees (first, last, department_id)
    values ('Adron', 'Hall', (select department_id from the_business.departments where name = 'Metal'));
insert into the_business.employees (first, last, department_id)
    values ('Amanda', 'Moran', (select department_id from the_business.departments where name = 'Code'));
insert into the_business.employees (first, last, department_id)
    values ('Karl', 'Matthias', (select department_id from the_business.departments where name = 'Bikey'));
