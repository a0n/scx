# Exercises
## Database
### requirements
requires recent docker with compose v2

### rationale
There are many robust features a mature database like postgresql can bring. Stored procedures, materialized views, and triggers can compliment an event driven architecture where that's valuable. Interesting data types like jsonb allow for schema flexibility where that's helpful.

What's included is just a simple hello world blog schema with a few foriegn keys. I didn't elaborate much beyond the stated requirements. When navigating situations with open ended or partial requirements, it's best to consult with stakeholders to understand the blog's contribution to its value stream, who the users are what they value, etc.

### build
* `make database`

An instance of postgresql and pgadmin are deployed locally through compose, and `schema.sql` is loaded. You may alternatively use `docker compose up|down|rm` commands to manage the containers.

### run
* http://localhost:5050  (credentials in compose.yaml)
or
* docker exec -ti pg_container psql

`schema.sql` is loaded as the named schema "blog" in the "root" database. `\d blog.*`

## Api Client

### requirements
any recent node: `brew install node@16`

### rationale

Node was chosen for its mature libraries/tooling in the web space. It is also a natural choice for performing many asynchronous requests, should that need arise. The solution is not so much a script, but command line utility program that implements the required operations. 

The guide asks for the the 200 most _recent_ TODOs, and while there are exactly 200 TODOs, there is no temporal data within the *todo* object or any related objects to establish their recency.

### run
* `make api-client`
* `./api-client.js --help`
* `./api-client.js --resource photos list --id 20-30,45,2-5`

## String Permutations
### requirements
any recent golang: `brew install go`

### rationale
Go was chosen because for its strong performance profile for algorthmic work while also being ergonimic enough to be straight to the point. The algorithm implemented is not optimal, but was chosen to value brevity and clarity over maximum efficiency.

### build
* `make permutations`

### run
* `./permutations permutations.sample.txt`