.PHONY: all clean test checks docker

checks: pc-run

pc-run:
	pre-commit run -a

docker: compose-up

compose-up:
	docker compose up --build

compose-down:
	docker compose down
