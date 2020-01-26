let apiBaseUrl = "http://localhost:4000";

type block = {
  id: int,
  restaurant_id: int,
  user: AuthData.user,
  user_id: int,
};

type blocks = array(block);

module Decode = {
  let block = (json): block => {
    Json.Decode.{
      id: json |> field("id", int),
      restaurant_id: json |> field("restaurant_id", int),
      user_id: json |> field("user_id", int),
      user: json |> field("user", AuthData.Decode.user),
    };
  };

  let blocks = (json): blocks => {
    Json.Decode.(json |> array(block));
  };
};

let fetchBlocks = (restaurantId, callback) =>
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/restaurants/$restaurantId/blocks|j},
      Fetch.RequestInit.make(
        ~method_=Get,
        ~headers=
          Fetch.HeadersInit.make({
            "Authorization": AuthData.getFromStorage("jwt"),
            "Content-Type": "application/json",
          }),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> then_(json =>
         json
         |> Json.Decode.(at(["data"], Decode.blocks))
         |> (
           blocks => {
             callback(blocks);
             resolve();
           }
         )
       )
    |> ignore
  ); /* TODO: error handling */

let blockUser = (restaurantId, body) =>
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/restaurants/$restaurantId/blocks|j},
      Fetch.RequestInit.make(
        ~method_=Post,
        ~body=Fetch.BodyInit.make(Js.Json.stringify(body)),
        ~headers=
          Fetch.HeadersInit.make({
            "Authorization": AuthData.getFromStorage("jwt"),
            "Content-Type": "application/json",
          }),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> ignore
  ); /* TODO: error handling */

let unblockUser = (restaurantId, blockId) =>
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/restaurants/$restaurantId/blocks/$blockId|j},
      Fetch.RequestInit.make(
        ~method_=Delete,
        ~headers=
          Fetch.HeadersInit.make({
            "Authorization": AuthData.getFromStorage("jwt"),
            "Content-Type": "application/json",
          }),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> ignore
  ); /* TODO: error handling */