let apiBaseUrl = "http://localhost:4000";

type order_meal = {
  id: int,
  meal: RestaurantData.meal,
  inserted_at: option(Js.Date.t),
  updated_at: option(Js.Date.t),
  meal_id: int,
  order_id: int,
  qty: int,
};

type order = {
  id: int,
  canceled_date: option(Js.Date.t),
  delivered_date: option(Js.Date.t),
  in_route_date: option(Js.Date.t),
  inserted_at: option(Js.Date.t),
  updated_at: option(Js.Date.t),
  placed_date: option(Js.Date.t),
  processing_date: option(Js.Date.t),
  received_date: option(Js.Date.t),
  restaurant_id: int,
  status: string,
  user_id: int,
  orders_meals: option(array(order_meal)),
};

type orders = array(order);

module Decode = {
  let order_meal = (json): order_meal => {
    Json.Decode.{
      id: json |> field("id", int),
      meal: json |> field("meal", RestaurantData.Decode.meal),
      inserted_at: json |> optional(field("inserted_at", date)),
      updated_at: json |> optional(field("updated_at", date)),
      meal_id: json |> field("meal_id", int),
      order_id: json |> field("order_id", int),
      qty: json |> field("qty", int),
    };
  };
  let order = (json): order => {
    Json.Decode.{
      canceled_date: json |> optional(field("canceled_date", date)),
      delivered_date: json |> optional(field("delivered_date", date)),
      in_route_date: json |> optional(field("in_route_date", date)),
      inserted_at: json |> optional(field("inserted_at", date)),
      updated_at: json |> optional(field("updated_at", date)),
      placed_date: json |> optional(field("placed_date", date)),
      processing_date: json |> optional(field("processing_date", date)),
      received_date: json |> optional(field("received_date", date)),
      restaurant_id: json |> field("restaurant_id", int),
      status: json |> field("status", string),
      user_id: json |> field("user_id", int),
      id: json |> field("id", int),
      orders_meals:
        json |> optional(field("orders_meals", array(order_meal))),
    };
  };

  let orders = (json): orders => {
    Json.Decode.(json |> array(order));
  };
};

let fetchOrders = callback => {
  Js.Promise.
    (
      Fetch.fetchWithInit(
        {j|$apiBaseUrl/api/v1/orders|j},
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
           |> Json.Decode.(at(["data"], Decode.orders))
           |> (
             orders => {
               callback(orders);
               resolve();
             }
           )
         })
      |> ignore
    ); /* TODO: error handling */
};

let postOrder = body => {
  Js.Promise.
    (
      Fetch.fetchWithInit(
        {j|$apiBaseUrl/api/v1/orders|j},
        Fetch.RequestInit.make(
          ~method_=Post,
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
      |> then_(json => {
           json
           |> Json.Decode.(at(["data"], Decode.order))
           |> (
             _orders => {
               resolve();
             }
           )
         })
      |> ignore
    ); /* TODO: error handling */
};

let updtateOrderStatus = (~id, ~status) => {
  Js.Promise.
    (
      Fetch.fetchWithInit(
        {j|$apiBaseUrl/api/v1/orders/$id/$status|j},
        Fetch.RequestInit.make(
          ~method_=Post,
          ~headers=
            Fetch.HeadersInit.make({
              "Content-Type": "application/json",
              "Authorization": AuthData.getFromStorage("jwt"),
            }),
          (),
        ),
      )
      |> then_(Fetch.Response.json)
      |> then_(json => {
           json
           |> Json.Decode.(at(["data"], Decode.order))
           |> (
             _orders => {
               resolve();
             }
           )
         })
      |> ignore
    ); /* TODO: error handling */
};