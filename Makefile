
.PHONY: database
database:
	@docker compose up

.PHONY: api-client
api-client: node_modules/.package-lock.json

node_modules/.package-lock.json : package-lock.json
	@npm install 

permutations: permutations.go
	@go build permutations.go