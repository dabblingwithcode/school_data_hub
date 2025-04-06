generate: ## generate updated models and create migrations
	serverpod generate
	serverpod create-migration

run: ## run the server
	docker compose up --build --detach
	dart run bin/main.dart --apply-migrations

reset: ## reset the server
	rmdir migrations
	mkdir migrations
	serverpod generate
	serverpod create-migration
	docker compose down --volumes --remove-orphans
	docker compose up --build --detach
	dart run bin/main.dart --role maintenance --apply-migrations