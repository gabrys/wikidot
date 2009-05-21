
all: db config finish

prepare_db:
	bin/prepare_db.php | psql

db:
	bin/bootstrap_db.php files/singlewiki-dump.sql
	bin/generate_om.php

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

