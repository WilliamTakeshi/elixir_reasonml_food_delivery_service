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
  | LoginPending;

let loginUser = (route, event, {ReasonReact.state, reduce}) => {
  ReactEventRe.Mouse.preventDefault(event);
  let reduceByAuthResult = (_status, jsonPayload) =>
    jsonPayload
    |> Js.Promise.then_(json => {
         let newUser = JsonRequests.checkForErrors(json);
         let updatedState =
           switch (newUser) {
           | Some(errors) => {
               ...state,
               hasValidationError: true,
               errorList: errors |> JsonRequests.convertErrorsToList,
             }
           | None =>
             let loggedIn = JsonRequests.parseNewUser(json);
             Effects.saveTokenToStorage(loggedIn.user.token);
             Effects.saveUserToStorage(
               loggedIn.user.username,
               loggedIn.user.bio,
             );
             DirectorRe.setRoute(route, "/home");
             {...state, hasValidationError: false};
           };
         let callLoginReducer = _payload =>
           Login((updatedState.hasValidationError, updatedState.errorList));
         reduce(callLoginReducer, ()) |> Js.Promise.resolve;
       });
  JsonRequests.authenticateUser(reduceByAuthResult, Encode.user(state))
  |> ignore;
  reduce(_ => LoginPending, ());
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
  };

let initialState = {
  email: "",
  password: "",
  hasValidationError: false,
  errorList: [],
};

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState);

  <div className="auth-page">
    <div className="container page">
      <div className="row">
        <div className="col-md-6 offset-md-3 col-xs-12">
          <h1 className="text-xs-center"> {str("Sign in")} </h1>
          <p className="text-xs-center">
            <a href="" onClick={_e => ReasonReact.Router.push("sign-in")}>
              {str("Need an account?")}
            </a>
            <form>
              <fieldset className="form-group">
                <input
                  type_="text"
                  className="form-control form-control-lg"
                  placeholder="Email"
                  value={state.email}
                  onChange={e =>
                    dispatch(EmailUpdate(ReactEvent.Form.target(e)##value))
                  }
                />
              </fieldset>
              <fieldset className="form-group">
                <input
                  type_="password"
                  className="form-control form-control-lg"
                  placeholder="Password"
                  value={state.password}
                  onChange={e =>
                    dispatch(
                      PasswordUpdate(ReactEvent.Form.target(e)##value),
                    )
                  }
                />
              </fieldset>
              <button className="btn btn-lg btn-primary pull-xs-right">
                {str("Sign in")}
              </button>
            </form>
          </p>
        </div>
      </div>
    </div>
  </div>;
};