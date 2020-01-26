let apiBaseUrl = "http://localhost:4000";

type restaurant = {
  description: string,
  id: int,
  imgUrl: string,
  name: string,
};

type meal = {
  active: bool,
  id: int,
  description: string,
  imgUrl: string,
  name: string,
  price: int,
  restaurantId: int,
};

type restaurant_with_meal = {
  description: string,
  id: int,
  imgUrl: string,
  name: string,
  meals: array(meal),
};

type restaurants = array(restaurant);

module Decode = {
  let meal = (json): meal => {
    Json.Decode.{
      description: json |> field("description", string),
      id: json |> field("id", int),
      active: json |> field("active", bool),
      name: json |> field("name", string),
      price: json |> field("price", int),
      restaurantId: json |> field("restaurant_id", int),
      imgUrl: json |> field("img_url", string),
    };
  };
  let restaurant = (json): restaurant => {
    Json.Decode.{
      description: json |> field("description", string),
      id: json |> field("id", int),
      imgUrl: json |> field("img_url", string),
      name: json |> field("name", string),
    };
  };

  let restaurantWithMeal = (json): restaurant_with_meal => {
    Json.Decode.{
      description: json |> field("description", string),
      id: json |> field("id", int),
      imgUrl: json |> field("img_url", string),
      name: json |> field("name", string),
      meals: json |> field("meals", array(meal)),
    };
  };

  let restaurants = (json): array(restaurant) =>
    Json.Decode.(json |> array(restaurant));
};

let fetchRestaurants = callback => {
  Js.Promise.
    (
      Fetch.fetchWithInit(
        {j|$apiBaseUrl/api/v1/restaurants|j},
        Fetch.RequestInit.make(
          ~method_=Get,
          ~headers=
            Fetch.HeadersInit.make({
              "Authorization": AuthData.getFromStorage("jwt"),
            }),
          (),
        ),
      )
      |> then_(Fetch.Response.json)
      |> then_(json => {
           json
           |> Json.Decode.(at(["data"], Decode.restaurants))
           |> (
             restaurants => {
               callback(restaurants);
               resolve();
             }
           )
         })
      |> ignore
    ); /* TODO: error handling */
};

let fetchRestaurantWithMeal = (id, callback) => {
  let strId = string_of_int(id);
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/restaurants/$strId|j},
      Fetch.RequestInit.make(
        ~method_=Get,
        ~headers=
          Fetch.HeadersInit.make({
            "Authorization": AuthData.getFromStorage("jwt"),
          }),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> then_(json =>
         json
         |> Json.Decode.(at(["data"], Decode.restaurantWithMeal))
         |> (
           restaurant => {
             callback(restaurant);
             resolve();
           }
         )
       )
    |> ignore
  ); /* TODO: error handling */
};

let updateRestaurant = (id, body) => {
  let strId = string_of_int(id);
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/restaurants/$strId|j},
      Fetch.RequestInit.make(
        ~method_=Put,
        ~body=Fetch.BodyInit.make(Js.Json.stringify(body)),
        ~headers=
          Fetch.HeadersInit.make({
            "Content-Type": "application/json",
            "Authorization": AuthData.getFromStorage("jwt"),
          }),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> ignore
  ); /* TODO: error handling */
};

let fetchMeal = (mealId, restaurantId, callback) => {
  let strMealId = string_of_int(mealId);
  let strRestaurantId = string_of_int(restaurantId);
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/restaurants/$strRestaurantId/meals/$strMealId|j},
      Fetch.RequestInit.make(
        ~method_=Get,
        ~headers=
          Fetch.HeadersInit.make({
            "Authorization": AuthData.getFromStorage("jwt"),
          }),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> then_(json =>
         json
         |> Json.Decode.(at(["data"], Decode.meal))
         |> (
           meal => {
             callback(meal);
             resolve();
           }
         )
       )
    |> ignore
  ); /* TODO: error handling */
};

let updateMeal = (mealId, restaurantId, body) => {
  let strMealId = string_of_int(mealId);
  let strRestaurantId = string_of_int(restaurantId);

  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/restaurants/$strRestaurantId/meals/$strMealId|j},
      Fetch.RequestInit.make(
        ~method_=Put,
        ~body=Fetch.BodyInit.make(Js.Json.stringify(body)),
        ~headers=
          Fetch.HeadersInit.make({
            "Content-Type": "application/json",
            "Authorization": AuthData.getFromStorage("jwt"),
          }),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> ignore
  ); /* TODO: error handling */
};