# The Symfony CMF Sandbox in docker 

## 0. Install
`git clone git@github.com:gorenstein/symfony-cmf-sandbox-docker.git`

## 1. First start or reset to default
### (Re)Init and up containers
 - `init_cmf.sh`

## 2. Next start
### Up containers
- `docker-compose up -d`

## 3. web UI
 - CMF: `http://localhost:8080`
 - phpMyAdmin: `http://localhost:8081` _(user|pass see in /.env)_
