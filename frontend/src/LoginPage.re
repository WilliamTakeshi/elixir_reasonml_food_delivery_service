/*
    TODO
    add error handler
 */

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

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState);

  let handleSubmit = state => {
    AuthData.login(state);
    ReasonReact.Router.push("/");
    dispatch(ResetState);
  };

  <div className="container">
    <div className="row">
      <div className="input-field col s6 offset-s3">
        <h1 className="text-xs-center"> {React.string("Login")} </h1>
        <Link href="/createaccount">
          {React.string("Need an account?")}
        </Link>
      </div>
    </div>
    <div className="row">
      <div className="input-field col s6 offset-s3">
        <input
          id="email"
          type_="text"
          className="validate"
          value={state.email}
          onChange={evt => Utils.valueFromEvent(evt)->EmailUpdate |> dispatch}
        />
        <label htmlFor="email"> {React.string("E-mail")} </label>
      </div>
    </div>
    <div className="row">
      <div className="input-field col s6 offset-s3">
        <input
          id="password"
          type_="password"
          className="validate"
          value={state.password}
          onChange={evt =>
            Utils.valueFromEvent(evt)->PasswordUpdate |> dispatch
          }
        />
        <label htmlFor="password"> {React.string("Password")} </label>
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
          {React.string("Login")}
        </button>
      </div>
    </div>
  </div>;
};