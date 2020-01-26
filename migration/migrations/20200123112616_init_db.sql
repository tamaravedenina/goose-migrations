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
insert into public.product values (3, 'test', 3, 'test', 3);
insert into public.product values (4, 'test', 4, 'test', 4);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
drop table public.product;

