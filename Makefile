
all: db keys config finish

prepare_db:
	bin/prepare_db.php | psql

db:
	bin/bootstrap_db.php files/dump/db/*.sql
	bin/generate_om.php
	bin/bootstrap_pages.php files/dump/sites/*

keys:
	bin/generate_keys.sh

config:
	bin/configure.php

finish:
	@echo
	@echo ============================================
	@echo make complete
	@echo ============================================
	@echo
	@echo Run Wikidot server with ./wikidotctl start
	@echo and navigate to the following URL to finish:
	@echo
	@bin/finish_url.php
	@echo

