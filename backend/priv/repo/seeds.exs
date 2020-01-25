# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodDelivery.Repo.insert!(%FoodDelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Pow.Ecto.Context.create(
  %{email: "owner@example.com", password: "password", confirm_password: "password"},
  otp_app: :food_delivery
)

Pow.Ecto.Context.create(
  %{email: "user@example.com", password: "password", confirm_password: "password"},
  otp_app: :food_delivery
)

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Restaurant{
  name: "Thai food",
  description: "delicious thai food",
  owner_id: 1,
  img_url:
    "http://rivista-cdn.hvmag.com/images/cache/cache_0/cache_f/cache_f/Fotolia_199459052_Subscription_Monthly_M-80f12ff0.jpeg?ver=1562845421&aspectratio=1.5"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Restaurant{
  name: "Brazilian food",
  description: "delicious brazilian food",
  owner_id: 2,
  img_url: "https://upload.wikimedia.org/wikipedia/commons/8/84/Feijoada_01.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Jok mu sap",
  description:
    "Of Chinese origin, it is a rice congee with minced chicken or pork. Mixing an egg in with the congee is optional.",
  price: 999,
  restaurant_id: 1,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Jok_mu_sap.JPG/800px-Jok_mu_sap.JPG"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Khao kha mu",
  description:
    "Steamed rice is served with sliced pig's trotters, which has been simmered in soy sauce and five spice powder. It is always served with a sweet spicy dipping sauce, fresh bird's eye chili peppers and cloves of garlic on the side. Boiled egg and a clear broth on the side are optional.",
  price: 1599,
  restaurant_id: 1,
  img_url: "https://upload.wikimedia.org/wikipedia/commons/6/68/Khao_kha_mu_02.JPG"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Mi krop",
  description: "Deep fried rice vermicelli with a sweet and sour sauce.",
  price: 1999,
  restaurant_id: 1,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Mee_krob_%28%E0%B8%AB%E0%B8%A1%E0%B8%B5%E0%B9%88%E0%B8%81%E0%B8%A3%E0%B8%AD%E0%B8%9A%29.jpg/800px-Mee_krob_%28%E0%B8%AB%E0%B8%A1%E0%B8%B5%E0%B9%88%E0%B8%81%E0%B8%A3%E0%B8%AD%E0%B8%9A%29.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Coxinha",
  description:
    "A popular food in many countries in South America. The drumstick is a snack Brazilian originally from São Paulo, but also common in Portugal, and based on dough made with wheat flour and chicken broth, which is filled with spiced chicken meat. ",
  price: 400,
  restaurant_id: 2,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Coxinha.jpg/600px-Coxinha.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Misto-quente",
  description: "It's a simple ham and cheese sandwich in sliced bread, with or without butter",
  price: 500,
  restaurant_id: 2,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Grilled_ham_and_cheese_014.JPG/800px-Grilled_ham_and_cheese_014.JPG"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Pastel",
  description:
    "In Brazil, pastel is a typical fast-food Brazilian dish, consisting of thin pastry envelopes wrapped around assorted fillings, then deep fried in vegetable oil. The result is a crispy, brownish pastry. The most common fillings are ground meat, mozzarella, heart of palm, catupiry cream cheese, chicken and small shrimp. Variants include pastel de angu.",
  price: 400,
  restaurant_id: 2,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Brazilian_pastel.jpg/800px-Brazilian_pastel.jpg"
})
