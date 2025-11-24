migration: ## generate updated models and create migrations
	serverpod generate
	serverpod create-migration
	dart run bin/main.dart --role maintenance --apply-migrations

docker: ## run docker container
	docker compose up --build --detach
	

reset: ## reset the server
	@powershell -NoProfile -Command "$$bold = [char]27 + '[1m'; $$reset = [char]27 + '[0m'; Write-Host \"$${bold}WARNING: This will reset the server and delete all data. Continue? (y/n)$${reset}\" -ForegroundColor Red -NoNewline; $$r = Read-Host; if ($$r -ne 'y' -and $$r -ne 'Y') { Write-Host 'Cancelled.' -ForegroundColor Yellow; exit 1 } else { Write-Host 'Resetting server...' -ForegroundColor Green }"
	cmd /c rmdir /Q /S migrations
	cmd /c mkdir migrations
	cmd /c rmdir /Q /S storage\private
	cmd /c mkdir storage\private
	cmd /c mkdir storage\private\avatars
	cmd /c mkdir storage\private\documents
	cmd /c mkdir storage\private\events
	cmd /c mkdir storage\private\auths
	cmd /c mkdir storage\private\temp
# 	## rm -r database_backups
# 	## mkdir database_backups
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

run: 
#	run the server
	dart run bin/main.dart --apply-migrations

uml: ## generate UML diagram
	dart run uml_for_serverpod --config=uml_config.yaml

install: ## serverpod vps branch
	dart pub global activate -sgit https://github.com/dart-lang/http.git --git-ref dart pub global activate -sgit https://github.com/dabblingwithcode/serverpod_vps.git --git-ref 36f98e900347335af2338a0e087538009b7de2f9

confirm: ## yes/no prompt (Windows compatible)
	@powershell -NoProfile -Command "$$bold = [char]27 + '[1m'; $$reset = [char]27 + '[0m'; Write-Host \"$${bold}WARNING: This will create a migration. Continue? (y/n)$${reset}\" -ForegroundColor Red -NoNewline; $$r = Read-Host; if ($$r -ne 'y' -and $$r -ne 'Y') { Write-Host 'Cancelled.' -ForegroundColor Yellow; exit 1 } else { Write-Host 'Proceeding...' -ForegroundColor Green }"
	serverpod create-migration
