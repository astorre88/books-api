# Minimal book shops API

## General description

Minimal API for handling publisher <-> bookshop comunications

## Setup

Prepare environment variables(in project we have the PostgreSQL DB, so default username and password is used both to be `postgres`):

```sh
printf 'DATABASE_USERNAME=postgres\nDATABASE_PASSWORD=postgres' > .env.development
printf 'DATABASE_USERNAME=postgres\nDATABASE_PASSWORD=postgres' > .env.test
```

Setup dependencies:

```sh
bundle
```

Create and prepare DB:

```sh
rails db:setup
```

## Start application

After this step you have working DB with all tables and some prepared rows in them.
So you can test it right now:

```sh
rails s

curl http://localhost:3000/api/v1/publishers/1/shops
# [{"id":3,"name":"Hatchards","books_sold_count":2,"books_in_stock":[{"id":1,"title":"Carrie","copies_in_stock":2},{"id":2,"title":"The Shining","copies_in_stock":0}]},{"id":1,"name":"Stanfords","books_sold_count":1,"books_in_stock":[{"id":1,"title":"Carrie","copies_in_stock":2},{"id":2,"title":"The Shining","copies_in_stock":2}]}]

curl http://localhost:3000/api/v1/publishers/2/shops
# {"id":2,"name":"Gosh!","books_sold_count":1,"books_in_stock":[{"id":3,"title":"Rage","copies_in_stock":2},{"id":4,"title":"The Long Walk","copies_in_stock":4}]}]

# Mark given copies as sold
curl -X PATCH http://localhost:3000/api/v1/shops/1/books/2 -H "Accept: application/json" -H "Content-Type: application/json" -d '{ "book": { "copies": 1 } }'

# Check solded
curl http://localhost:3000/api/v1/publishers/1/shops
# [{"id":3,"name":"Hatchards","books_sold_count":2,"books_in_stock":[{"id":1,"title":"Carrie","copies_in_stock":2},{"id":2,"title":"The Shining","copies_in_stock":0}]},{"id":1,"name":"Stanfords","books_sold_count":2,"books_in_stock":[{"id":1,"title":"Carrie","copies_in_stock":2},{"id":2,"title":"The Shining","copies_in_stock":1}]}]
```

## Run specs

```sh
rspec
```
