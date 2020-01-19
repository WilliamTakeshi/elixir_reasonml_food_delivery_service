let apiBaseUrl = "http://localhost:4000";

type restaurant = {
  description: string,
  id: int,
  img_url: string,
  name: string,
};

type meal = {
  active: bool,
  id: int,
  description: string,
  img_url: string,
  name: string,
  price: int,
  restaurant_id: int,
};

type restaurant_with_meal = {
  description: string,
  id: int,
  img_url: string,
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
      restaurant_id: json |> field("restaurant_id", int),
      img_url: json |> field("img_url", string),
    };
  };
  let restaurant = (json): restaurant => {
    Json.Decode.{
      description: json |> field("description", string),
      id: json |> field("id", int),
      img_url: json |> field("img_url", string),
      name: json |> field("name", string),
    };
  };

  let restaurantWithMeal = (json): restaurant_with_meal => {
    Json.Decode.{
      description: json |> field("description", string),
      id: json |> field("id", int),
      img_url: json |> field("img_url", string),
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
      Fetch.fetch({j|$apiBaseUrl/api/v1/restaurants|j})
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
    Fetch.fetch({j|$apiBaseUrl/api/v1/restaurants/$strId|j})
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