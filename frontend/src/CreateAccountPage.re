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
    dispatch(ResetState);
  };

  <div className="auth-page">
    <div className="container page">
      <div className="row">
        <div className="col-md-6 offset-md-3 col-xs-12">
          <h1 className="text-xs-center"> {str("Create an account")} </h1>
          <Link href="/"> {React.string("Already have an account")} </Link>
          <input
            type_="text"
            className="form-control form-control-lg"
            placeholder="Email"
            value={state.email}
            onChange={evt =>
              Utils.valueFromEvent(evt)->EmailUpdate |> dispatch
            }
          />
          <input
            type_="password"
            className="form-control form-control-lg"
            placeholder="Password"
            value={state.password}
            onChange={evt =>
              Utils.valueFromEvent(evt)->PasswordUpdate |> dispatch
            }
          />
          <input
            type_="password"
            className="form-control form-control-lg"
            placeholder="Confirm Password"
            value={state.confirmPassword}
            onChange={evt =>
              Utils.valueFromEvent(evt)->ConfirmPasswordUpdate |> dispatch
            }
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
                        ("confirm_password", string(state.confirmPassword)),
                      ]),
                    ),
                  ])
                ),
              )
            }
            className="btn btn-lg btn-primary pull-xs-right">
            {str("Create")}
          </button>
        </div>
      </div>
    </div>
  </div>;
};