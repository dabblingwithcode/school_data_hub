generate: ## generate updated models and create migrations
	serverpod generate
	serverpod create-migration
	dart run bin/main.dart --role maintenance --apply-migrations

run: ## run the server
	docker compose up --build --detach
	dart run bin/main.dart --apply-migrations

reset: ## reset the server
	rm -r migrations
	mkdir migrations
	rm -r database_backups
	mkdir database_backups
	serverpod generate
	serverpod create-migration
	docker compose down --volumes --remove-orphans
	docker compose up --build --detach
	dart run bin/main.dart --role maintenance --apply-migrations