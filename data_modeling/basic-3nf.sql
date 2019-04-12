create schema if not exists the_business;

create table if not exists the_business.departments
(
    department_id uuid                not null
        constraint departments_pk
            primary key,
    name          varchar default 150 not null
);

create table if not exists the_business.employees
(
    employee_id   uuid                not null
        constraint employees_pk
            primary key,
    first         varchar default 100 not null,
    last          varchar default 100 not null,
    department_id uuid                not null
        constraint employees_departments_fk
            references the_business.departments
            on update cascade on delete set default,
    start         date                not null
);

alter table the_business.departments
    owner to postgres;

alter table the_business.employees
    owner to postgres;
