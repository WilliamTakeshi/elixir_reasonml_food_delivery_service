# FoodDelivery BackEnd

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`
- Script for populating the database `mix run priv/repo/seeds.exs`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Seeds

The seed start some users listed below

- Owner of the restaurant with `id: 1` `email: "owner@example.com", password: "password"`
- Regular user `email: "user@example.com", password: "password"`

The seed also start some restaurants and meals for easier testing

## Tests

To run tests you can use `mix test`

All tests are async so it is really fast to add new tests and doesn't hit the performance too much

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
