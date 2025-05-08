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
	cmd /c mkdir storage\private\temp
	# rm -r database_backups
	# mkdir database_backups
	serverpod generate
	serverpod create-migration
	docker compose down --volumes --remove-orphans
	docker compose up --build --detach
	dart run bin/main.dart --role maintenance --apply-migrations

reset_mac: ## reset the server
	rm -rf migrations
	mkdir -p migrations
	rm -rf storage/private
	mkdir -p storage/private
	mkdir -p storage/private/avatars
	mkdir -p storage/private/documents
	mkdir -p storage/private/events
	mkdir -p storage/private/auths
	mkdir -p storage/private/temp
	# rm -r database_backups
	# mkdir database_backups
	serverpod generate
	serverpod create-migration
	docker compose down --volumes --remove-orphans
	docker compose up --build --detach
	dart run bin/main.dart --role maintenance --apply-migrations