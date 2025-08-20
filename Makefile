include .env
export

.PHONY: run
run:
	bin/dev;

.PHONY: migrate
migrate:
	rails db:migrate;

.PHONY: test-all
test-all:
	bundle exec rspec;

.PHONY: seed
seed:
	rails db:seed;

.PHONY: test
test:
	bundle exec rspec --exclude-pattern "spec/features/**/*_spec.rb";

.PHONY: e2e
e2e:
	bundle exec rspec --pattern "spec/features/**/*_spec.rb";

.PHONY: db-up
db-up:
	docker compose up -d db;

.PHONY: db-down
db-down:
	docker compose down db;

.PHONY: db-reset
db-reset:
	rails db:drop db:create db:migrate;

.PHONY: lint
lint:
	bundle exec rubocop -a;

.PHONY: app-up
app-up:
	docker compose up -d app;

.PHONY: app-down
app-down:
	docker compose down app;