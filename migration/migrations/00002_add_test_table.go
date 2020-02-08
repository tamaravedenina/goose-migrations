package migrations

import (
	"database/sql"

	"github.com/pressly/goose"
)

func init() {
	goose.AddMigration(Up00002, Down00002)
}

func Up00002(tx *sql.Tx) error {
	query := `create table test (
	id         bigint       not null primary key,
	name       varchar(100) not null,
	key        varchar(100) not null,
	created_at timestamp    not null default now());`
	_, err := tx.Exec(query)
	if err != nil {return err}
	return nil
}

func Down00002(tx *sql.Tx) error {
	query := `drop table test`
	_, err := tx.Exec(query)
	if err != nil {
		return err
	}
	return nil
}
