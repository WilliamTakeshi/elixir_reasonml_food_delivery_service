let apiBaseUrl = "http://localhost:4000";

type token = {
  token: string,
  renew_token: string,
};

let saveTokenToStorage = value => {
  Dom.Storage.(localStorage |> setItem("jwt", value));
};

let getTokenFromStorage = () => {
  Dom.Storage.(localStorage |> getItem("jwt"));
};

let saveRenewTokenToStorage = value => {
  Dom.Storage.(localStorage |> setItem("jwt", value));
};

let getRenewTokenFromStorage = () => {
  Dom.Storage.(localStorage |> getItem("jwt"));
};

let isUserLoggedIn = () => {
  switch (getTokenFromStorage()) {
  | None => false
  | Some(_) => true
  };
};
module Decode = {
  let token = (json): token => {
    Json.Decode.{
      token: json |> field("token", string),
      renew_token: json |> field("renew_token", string),
    };
  };
};

let login = body =>
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
         |> Json.Decode.(at(["data"], Decode.token))
         |> (
           token => {
             saveTokenToStorage(token.token);
             saveRenewTokenToStorage(token.renew_token);
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
         |> Json.Decode.(at(["data"], Decode.token))
         |> (
           _login => {
             resolve();
           }
         )
       )
    |> ignore
  ); /* TODO: error handling */