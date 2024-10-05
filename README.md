# MS SQL Server + Adminer deployment

* It works on Linux (Ubuntu 24.04 LTS)

## For run containers in Docker Compose:

1) Go to directory with this repository.

2) Copy `.env.example` to `.env`:
    ```bash
    cp .env.example .env
    ```
    Put your env vars to `.env`. Example in `.env.example`.

3) Run the command `make run` below
    - If the container has not started, inspect errors `docker logs <conteiner_id>`
    - If there are few access rights, run `sudo make chown`

4) Connect to the database in SQL Client (for example, [Adminer](http://localhost:8080)) and check that it works.

## For up DB from backup in Docker container
Go to [commands.md](./commands.md)

## Run with `make`:

- For install `make` run (in Ubuntu):
    ```bash
    sudo apt install make
    ```

### Up all containers
```bash
make run
```

### Stop all containers
```bash
make stop
```

### Stop and Remove all containers
```bash
make down
```

### Clean volumes (requires sudo)
```bash
make clean
```

If you don't have utility `make`, run commands from [Makefile](./Makefile)

<br/>

This repository was created to study SQL in the `Data Bases` course at NUST `MISIS` 22.09.24