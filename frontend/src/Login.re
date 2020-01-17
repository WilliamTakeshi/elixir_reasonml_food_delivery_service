// open Belt;

let apiBaseUrl = "http://localhost:4000";

let str = ReasonReact.string;
type state = {
  email: string,
  password: string,
  hasValidationError: bool,
  errorList: list(string),
};

type action =
  | EmailUpdate(string)
  | PasswordUpdate(string)
  | Login((bool, list(string)))
  | LoginPending
  | ResetState;

let initialState = {
  email: "",
  password: "",
  hasValidationError: false,
  errorList: [],
};

let reducer = (state, action) =>
  switch (action) {
  | EmailUpdate(value) => {...state, email: value}
  | PasswordUpdate(value) => {...state, password: value}
  | Login((hasError, errorList)) => {
      ...state,
      hasValidationError: hasError,
      errorList,
    }
  | LoginPending => state
  | ResetState => initialState
  };

let valueFromEvent = (evt): string => evt->ReactEvent.Form.target##value;

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

let postLogin = state =>
  Js.Promise.(
    Fetch.fetchWithInit(
      {j|$apiBaseUrl/api/v1/session|j},
      Fetch.RequestInit.make(
        ~method_=Post,
        ~body=Fetch.BodyInit.make(Js.Json.stringify(state)),
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

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState);

  let handleSubmit = state => {
    postLogin(state);
    dispatch(ResetState);
  };

  <div className="auth-page">
    <div className="container page">
      <div className="row">
        <div className="col-md-6 offset-md-3 col-xs-12">
          <h1 className="text-xs-center"> {str("Sign in")} </h1>
          <a href="" onClick={_e => ReasonReact.Router.push("sign-in")}>
            {str("Need an account?")}
          </a>
          <input
            type_="text"
            className="form-control form-control-lg"
            placeholder="Email"
            value={state.email}
            onChange={evt => valueFromEvent(evt)->EmailUpdate |> dispatch}
          />
          <input
            type_="password"
            className="form-control form-control-lg"
            placeholder="Password"
            value={state.password}
            onChange={evt => valueFromEvent(evt)->PasswordUpdate |> dispatch}
          />
          <button
            onClick={_evt =>
              handleSubmit(
                Json.Encode.(
                  object_([
                    (
                      "user",
                      object_([
                        ("email", string(state.email)),
                        ("password", string(state.password)),
                      ]),
                    ),
                  ])
                ),
              )
            }
            className="btn btn-lg btn-primary pull-xs-right">
            {str("Sign in")}
          </button>
        </div>
      </div>
    </div>
  </div>;
};