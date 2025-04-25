generate: ## generate updated models and create migrations
	serverpod generate
	serverpod create-migration
	dart run bin/main.dart --role maintenance --apply-migrations

docker: ## run docker container
	docker compose up --build --detach
	

reset: ## reset the server
	# rmdir migrations /s /q
	# mkdir migrations
	# rm -r database_backups
	# mkdir database_backups
	serverpod generate
	serverpod create-migration
	docker compose down --volumes --remove-orphans
	docker compose up --build --detach
	dart run bin/main.dart --role maintenance --apply-migrations