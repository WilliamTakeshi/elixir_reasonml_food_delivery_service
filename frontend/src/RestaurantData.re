let apiBaseUrl = "http://localhost:4000";

type restaurant = {
  description: string,
  id: int,
  img_url: string,
  name: string,
};

type restaurants = array(restaurant);

module Decode = {
  let restaurant = (json): restaurant => {
    Json.Decode.{
      description: json |> field("description", string),
      id: json |> field("id", int),
      img_url: json |> field("img_url", string),
      name: json |> field("name", string),
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