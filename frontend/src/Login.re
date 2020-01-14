let str = ReasonReact.string;
type state = {
  email: string,
  password: string,
  hasValidationError: bool,
  errorList: list(string),
};

type action =
  | Login((bool, list(string)))
  | EmailUpdate(string)
  | PasswordUpdate(string)
  | LoginPending;

[@react.component]
let make = () =>
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
                  // value={state.email}
                  // onChange={reduce(updateEmail)}
                />
              </fieldset>
              <fieldset className="form-group">
                <input
                  type_="password"
                  className="form-control form-control-lg"
                  placeholder="Password"
                  // value={state.password}
                  // onChange={reduce(updatePassword)}
                />
              </fieldset>
              // onClick={self.handle(loginUser(router))}
              <button className="btn btn-lg btn-primary pull-xs-right">
                {str("Sign in")}
              </button>
            </form>
          </p>
        </div>
      </div>
    </div>
  </div>;