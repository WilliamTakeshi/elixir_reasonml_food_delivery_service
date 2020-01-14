[@react.component]
let make = () => {
  let url = ReasonReact.Router.useUrl();

  switch (url.path) {
  | [] => <Login />
  | ["arst"] => <NotFound />
  | _ => <NotFound />
  };
};