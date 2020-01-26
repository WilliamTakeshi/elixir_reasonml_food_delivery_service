/*
    TODO
    pass same
    password lenght (8 characters)
    email already used
    email invalid format
 */
let str = ReasonReact.string;

type state = {
  email: string,
  password: string,
  confirmPassword: string,
  hasValidationError: bool,
  errorList: list(string),
};

type action =
  | EmailUpdate(string)
  | PasswordUpdate(string)
  | ConfirmPasswordUpdate(string)
  | ResetState;

let initialState = {
  email: "",
  password: "",
  confirmPassword: "",
  hasValidationError: false,
  errorList: [],
};

let reducer = (state, action) =>
  switch (action) {
  | EmailUpdate(value) => {...state, email: value}
  | PasswordUpdate(value) => {...state, password: value}
  | ConfirmPasswordUpdate(value) => {...state, confirmPassword: value}
  | ResetState => initialState
  };

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState);

  let handleSubmit = state => {
    AuthData.registration(state);
    ReasonReact.Router.push("/");
    dispatch(ResetState);
  };

  <div className="container ">
    <div className="row">
      <div className="input-field col s6 offset-s3">
        <h1 className="text-xs-center">
          {React.string("Create an account")}
        </h1>
        <Link href="/"> {React.string("Already have an account")} </Link>
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
      </div>
    </div>
    <div className="row">
      <div className="input-field col s6 offset-s3">
        <input
          id="confirm_password"
          type_="password"
          className="validate"
          value={state.confirmPassword}
          onChange={evt =>
            Utils.valueFromEvent(evt)->ConfirmPasswordUpdate |> dispatch
          }
        />
        <label htmlFor="confirm_password">
          {React.string("Confirm Password")}
        </label>
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
                      ("confirm_password", string(state.confirmPassword)),
                    ]),
                  ),
                ])
              ),
            )
          }
          className="btn btn-lg btn-primary pull-xs-right">
          {React.string("Create")}
        </button>
      </div>
    </div>
  </div>;
};