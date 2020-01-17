let apiBaseUrl = "http://localhost:4000";

type login = {
  token: string,
  renew_token: string,
};

module Decode = {
  let loginResponse = (json): login => {
    Json.Decode.{
      token: json |> field("token", string),
      renew_token: json |> field("renew_token", string),
    };
  };
};

let postLogin = body =>
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/session|j},
      Fetch.RequestInit.make(
        ~method_=Post,
        ~body=Fetch.BodyInit.make(Js.Json.stringify(body)),
        ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> then_(json =>
         json
         |> Decode.loginResponse
         |> (
           _login => {
             resolve();
           }
         )
       )
    |> ignore
  ); /* TODO: error handling */

let registration = body =>
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/registration|j},
      Fetch.RequestInit.make(
        ~method_=Post,
        ~body=Fetch.BodyInit.make(Js.Json.stringify(body)),
        ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> then_(json =>
         json
         |> Decode.loginResponse
         |> (
           _login => {
             resolve();
           }
         )
       )
    |> ignore
  ); /* TODO: error handling */