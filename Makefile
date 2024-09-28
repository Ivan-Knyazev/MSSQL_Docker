.PHONY: run clean chown stop down


run:
	mkdir -p ./volumes/ms-sql/
	docker compose up -d

stop:
	docker stop ms-sql adminer

down:
	docker compose down

clean:
	rm -rf ./volumes/

chown:
	chown -R 10001:10001 ./volumes/ms-sql/