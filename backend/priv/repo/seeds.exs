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
  %{
    email: "owner@example.com",
    password: "password",
    confirm_password: "password"
  },
  otp_app: :food_delivery
)

Pow.Ecto.Context.create(
  %{
    email: "owner2@example.com",
    password: "password",
    confirm_password: "password"
  },
  otp_app: :food_delivery
)

Pow.Ecto.Context.create(
  %{
    email: "owner3@example.com",
    password: "password",
    confirm_password: "password"
  },
  otp_app: :food_delivery
)

Pow.Ecto.Context.create(
  %{
    email: "owner4@example.com",
    password: "password",
    confirm_password: "password"
  },
  otp_app: :food_delivery
)

Pow.Ecto.Context.create(
  %{
    email: "owner5@example.com",
    password: "password",
    confirm_password: "password"
  },
  otp_app: :food_delivery
)

Pow.Ecto.Context.create(
  %{
    email: "owner6@example.com",
    password: "password",
    confirm_password: "password"
  },
  otp_app: :food_delivery
)

FoodDelivery.Users.set_owner_role(1)
FoodDelivery.Users.set_owner_role(2)
FoodDelivery.Users.set_owner_role(3)
FoodDelivery.Users.set_owner_role(4)
FoodDelivery.Users.set_owner_role(5)
FoodDelivery.Users.set_owner_role(6)

Pow.Ecto.Context.create(
  %{email: "user@example.com", password: "password", confirm_password: "password", role: "owner"},
  otp_app: :food_delivery
)

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Restaurant{
  name: "Thai Food",
  description: "delicious thai dishes",
  owner_id: 1,
  img_url:
    "http://rivista-cdn.hvmag.com/images/cache/cache_0/cache_f/cache_f/Fotolia_199459052_Subscription_Monthly_M-80f12ff0.jpeg?ver=1562845421&aspectratio=1.5"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Restaurant{
  name: "Brazilian Food",
  description: "delicious brazilian dishes",
  owner_id: 2,
  img_url: "https://upload.wikimedia.org/wikipedia/commons/8/84/Feijoada_01.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Restaurant{
  name: "Chinese Food",
  description: "delicious chinese dishes",
  owner_id: 3,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/China_table_setting.jpg/800px-China_table_setting.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Restaurant{
  name: "Mexican Food",
  description: "delicious mexican dishes",
  owner_id: 4,
  img_url: "https://upload.wikimedia.org/wikipedia/commons/9/9e/Carnitas.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Restaurant{
  name: "Portuguese Food",
  description: "delicious portuguese dishes",
  owner_id: 5,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Caldo_verde_-_Jul_2008.jpg/800px-Caldo_verde_-_Jul_2008.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Restaurant{
  name: "Japanese Food",
  description: "delicious japanese dishes",
  owner_id: 6,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Breakfast_by_tiseb_in_Toya%2C_Hokkaido.jpg/800px-Breakfast_by_tiseb_in_Toya%2C_Hokkaido.jpg"
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
    "Steamed rice is served with sliced pig's trotters, which has been simmered in soy sauce and five spice powder.",
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
  description: "Wheat flour and chicken broth, which is filled with spiced chicken meat. ",
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
  description: "Pastry envelopes wrapped around assorted fillings, then deep fried in vegetable.",
  price: 400,
  restaurant_id: 2,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Brazilian_pastel.jpg/800px-Brazilian_pastel.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Chow mein",
  description: "stir-fried noodles",
  price: 400,
  restaurant_id: 3,
  img_url: "https://upload.wikimedia.org/wikipedia/commons/d/d1/Chow_mein_1_by_yuen.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Char siu",
  description: "Chinese barbecued pork",
  price: 400,
  restaurant_id: 3,
  img_url: "https://upload.wikimedia.org/wikipedia/commons/9/95/Charsiu.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Peking Duck",
  description: "the trademark dish of Beijing",
  price: 400,
  restaurant_id: 3,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Peking_Duck_3.jpg/800px-Peking_Duck_3.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Bionico",
  description: "strawberries, banana, raisins, shredded coconut and granola",
  price: 400,
  restaurant_id: 4,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Bionico_Close_Up.jpg/600px-Bionico_Close_Up.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Cochinita pibil ",
  description:
    "traditional Mexican slow-roasted pork dish from the Yucatán Peninsula of Mayan origin",
  price: 400,
  restaurant_id: 4,
  img_url: "https://upload.wikimedia.org/wikipedia/commons/8/84/Cochinita_pibil_2.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "caldo de pollo",
  description: "chicken soup",
  price: 400,
  restaurant_id: 4,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Caldo_de_Pollo_%282411932823%29.jpg/800px-Caldo_de_Pollo_%282411932823%29.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Pastéis de bacalhau",
  description: "codfish pastries",
  price: 400,
  restaurant_id: 5,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/DSC_4018_%283799768917%29.jpg/800px-DSC_4018_%283799768917%29.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Chicken Piripiri",
  description: "",
  price: 400,
  restaurant_id: 5,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Chicken_Piripiri%2C26_July_2015_%286%29.JPG/800px-Chicken_Piripiri%2C26_July_2015_%286%29.JPG"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Bife com ovo à cavalo",
  description: "",
  price: 400,
  restaurant_id: 5,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/Bife_com_ovo_a_cavalo.jpg/800px-Bife_com_ovo_a_cavalo.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Chahan",
  description: "",
  price: 400,
  restaurant_id: 6,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Chahan_ball.jpg/800px-Chahan_ball.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Omurice",
  description: "",
  price: 400,
  restaurant_id: 6,
  img_url:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Omurice_by_jetalone_in_a_downtown%2C_Tokyo.jpg/800px-Omurice_by_jetalone_in_a_downtown%2C_Tokyo.jpg"
})

FoodDelivery.Repo.insert!(%FoodDelivery.Menu.Meal{
  name: "Oyakodon",
  description: "",
  price: 400,
  restaurant_id: 6,
  img_url: "https://upload.wikimedia.org/wikipedia/commons/3/36/Oyakodon_by_kina3.jpg"
})
