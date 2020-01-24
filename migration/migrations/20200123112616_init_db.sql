-- +goose Up
-- SQL in this section is executed when the migration is applied.

create table public.product
(
    id          bigint       not null primary key,
    name        varchar(500) not null,
    price       integer      not null default 0,
    brand       varchar(100) not null default '',
    description text,
    rating      float        not null default 0,
    created_at  timestamp    not null default now(),
    updated_at  timestamp    not null default now()
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.

drop table if exists public.product;

