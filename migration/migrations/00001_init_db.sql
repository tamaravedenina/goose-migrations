-- 00001_init_db.sql

-- +goose Up
-- SQL in this section is executed when the migration is applied.
create table public.product
(
    id          bigint       not null primary key,
    name        varchar(500) not null,
    price       integer      not null default 0,
    description text,
    rating      float        not null default 0,
    created_at  timestamp    not null default now()
);
insert into public.product values (1, 'test', 1, 'test', 1);
insert into public.product values (2, 'test', 2, 'test', 2);
create table if not exists public.attribute
(
    id         bigint       not null primary key,
    name       varchar(100) not null,
    key        varchar(100) not null,
    created_at timestamp    not null default now()
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
drop table public.attribute;
drop table public.product;

