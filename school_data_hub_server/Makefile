generate: ## generate updated models and create migrations
	serverpod generate
	serverpod create-migration
	dart run bin/main.dart --role maintenance --apply-migrations

docker: ## run docker container
	docker compose up --build --detach
	

reset: ## reset the server
	cmd /c rmdir /Q /S migrations
	cmd /c mkdir migrations
	cmd /c rmdir /Q /S storage\private
	cmd /c mkdir storage\private
	cmd /c mkdir storage\private\avatars
	cmd /c mkdir storage\private\documents
	cmd /c mkdir storage\private\events
	cmd /c mkdir storage\private\auths
	# rm -r database_backups
	# mkdir database_backups
	serverpod generate
	serverpod create-migration
	docker compose down --volumes --remove-orphans
	docker compose up --build --detach
	dart run bin/main.dart --role maintenance --apply-migrations