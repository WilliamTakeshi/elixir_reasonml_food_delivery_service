let apiBaseUrl = "http://localhost:4000";

type token = {
  token: string,
  renew_token: string,
};

type user = {
  id: int,
  email: string,
  role: string,
};

let saveToStorage = (key_: string, value) => {
  Dom.Storage.(localStorage |> setItem(key_, value));
};

let getFromStorage = (key_: string) => {
  Dom.Storage.(localStorage |> getItem(key_));
};

let removeFromStorage = (key_: string) => {
  Dom.Storage.(localStorage |> removeItem(key_));
};

let isUserLoggedIn = () => {
  switch (getFromStorage("jwt")) {
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

  let user = (json): user => {
    Json.Decode.{
      id: json |> field("id", int),
      email: json |> field("email", string),
      role: json |> field("role", string),
    };
  };
};

let me = () =>
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/me|j},
      Fetch.RequestInit.make(
        ~method_=Get,
        ~headers=
          Fetch.HeadersInit.make({
            "Authorization": getFromStorage("jwt"),
            "Content-Type": "application/json",
          }),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> then_(json =>
         json
         |> Json.Decode.(at(["data"], Decode.user))
         |> (
           user => {
             saveToStorage("user_role", user.role);
             resolve();
           }
         )
       )
    |> ignore
  ); /* TODO: error handling */


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
             saveToStorage("jwt", token.token);
             saveToStorage("renew_token", token.renew_token);
             me();
             resolve();
           }
         )
       )
    |> ignore
  ); /* TODO: error handling */

let logout = () =>
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/session|j},
      Fetch.RequestInit.make(
        ~method_=Delete,
        ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
        (),
      ),
    )
    |> then_(Fetch.Response.json)
    |> then_(_json => {
         removeFromStorage("jwt");
         removeFromStorage("renew_token");
         resolve();
       })
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

let confirmEmail = (token: string, callback) => {
  Js.Promise.
    (
      Fetch.fetch({j|$apiBaseUrl/api/v1/confirm_email/$token|j})
      |> then_(Fetch.Response.json)
      |> then_(_json => {
           callback(_ => "Email confirmed with success");
           Js.Global.setTimeout(_ => ReasonReact.Router.push("/"), 1500)
           |> ignore;
           resolve();
         })
      |> ignore
    ); /* TODO: error handling */
};