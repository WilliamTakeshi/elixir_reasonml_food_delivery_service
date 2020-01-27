[@react.component]
let make = () => {
  React.useEffect0(() => {
    AuthData.logout() |> ignore;
    ReasonReact.Router.push("/login") |> ignore;
    None;
  });
  <div> {React.string("Redirecting...")} </div>;
};