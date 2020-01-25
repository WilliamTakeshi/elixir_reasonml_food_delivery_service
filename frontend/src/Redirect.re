[@react.component]
let make = (~href) => {
  React.useEffect0(() => {
    ReasonReact.Router.push(href) |> ignore;
    None;
  });
  <div> {React.string("Redirecting...")} </div>;
};