
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
    department_name          varchar default 150 not null
);