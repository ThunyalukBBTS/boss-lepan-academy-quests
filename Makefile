.PHONY: run
run:
	bin/dev;

.PHONY: migrate
migrate:
	rails db:migrate;

.PHONY: test
test:
	bundle exec rspec;

.PHONY: db-up
db-up:
	docker compose up -d db;

.PHONY: db-down
db-down:
	docker compose down db;

.PHONY: db-reset
db-reset:
	rails db:reset db:migrate;

.PHONY: lint
lint:
	bundle exec rubocop -a;