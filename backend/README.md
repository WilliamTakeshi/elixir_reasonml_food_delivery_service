# FoodDelivery BackEnd

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`
- Script for populating the database `mix run priv/repo/seeds.exs`
- Reset the database and start from seed `mix reset`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Postman

You can import the API on Postman using the link: https://www.getpostman.com/collections/d09e15f4eb4427df7fca

## Seeds

The seed start some users listed below

- Owner of the restaurant with `id: 1` `email: "owner@example.com", password: "password"`
- Owner of the restaurant with `id: 2` `email: "owner2@example.com", password: "password"`
- Owner of the restaurant with `id: 3` `email: "owner3@example.com", password: "password"`
- Owner of the restaurant with `id: 4` `email: "owner4@example.com", password: "password"`
- Owner of the restaurant with `id: 5` `email: "owner5@example.com", password: "password"`
- Owner of the restaurant with `id: 6` `email: "owner6@example.com", password: "password"`
- Regular user `email: "user@example.com", password: "password"`

The seed also start some restaurants and meals for easier testing

## Config

All configuration is divided in `config/config.exs` `config/dev.exs`, `config/test.exs`, `config/prod.exs` and `config/prod.secret.exs`

- `config/config.exs`: is loaded on all configs
- `config/dev.exs`: is loaded when setting the env variable MIX_ENV=dev (default)
- `config/test.exs`: is loaded when setting the env variable MIX_ENV=test (default for some commands like `mix dev`)
- `config/prod.exs`: is loaded when setting the env variable MIX_ENV=prod, this one should be used when creating releases
- `config/prod.secret.exs`: is loaded when setting the env variable MIX_ENV=prod, this file is not on git, all keys should be here

## Tests

To run tests you can use `mix test`

Many tests are async, because Ecto.Adapters.SQL.Sandbox async tests involving a database can be done without worry. This means that the vast majority of tests in your Phoenix application will be able to be run asynchronously

So it is really fast to add new tests and doesn't hit the performance too much

'''Finished in 33.6 seconds
51 tests, 0 failures'''

## How to contribute

The project is divided in 4 main contexts and a couple of assistence modules

### Users - Context

Here is where all authentication context lies, Users context is responsible of session, register, e-mail confirmation, reset password, etc

### Menu - Context

Here is where all menu context lies, Menu context is responsible of all CRUD of restaurants and meals.

### Cart - Context

Cart context is responsible of all CRUD of orders and orders_meals.

### Permission - Context

Permission context is responsible of all CRUD of blocking users.

### Policy - Module

Policy makes the verification if the user can use this endpoint, it takes care of roles.
