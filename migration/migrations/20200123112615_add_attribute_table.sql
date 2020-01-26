-- +goose Up
-- SQL in this section is executed when the migration is applied.
create table public.attribute
(
    id         bigint       not null primary key,
    name       varchar(100) not null,
    key        varchar(100) not null,
    created_at timestamp    not null default now()
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
drop table public.attribute;
