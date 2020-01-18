/*
    TODO
    Add check is logged in
    router if logged incorrectly
 */

[@react.component]
let make = () => {
  let url = ReasonReact.Router.useUrl();

  switch (url.path) {
  | [] => <LoginPage />
  | ["createaccount"] => <CreateAccountPage />
  | ["restaurants"] => <RestaurantsPage />
  | ["restaurants", id] => <RestaurantPage id={int_of_string(id)} />
  | _ => <NotFoundPage />
  };
};