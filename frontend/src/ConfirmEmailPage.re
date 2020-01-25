[@react.component]
let make = (~token) => {
  let (message: string, setMessage) = React.useState(() => "");
  React.useEffect0(() => {
    AuthData.confirmEmail(token, setMessage) |> ignore;
    None;
  });

  <div className="container ">
    <div className="col s6 offset-s6"> <p> {React.string(message)} </p> </div>
  </div>;
};