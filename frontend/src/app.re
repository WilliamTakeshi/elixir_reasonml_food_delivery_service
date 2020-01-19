/*
    TODO
    Add check is logged in
    router if logged incorrectly
 */

[@react.component]
let make = () => {
  let url = ReasonReact.Router.useUrl();
  if (!AuthData.isUserLoggedIn() && url.path != ["login"]) {
    ReasonReact.Router.push("/login");
  };

  <div>
    <Nav />
    {switch (url.path, AuthData.isUserLoggedIn()) {
     | ([], true)
     | (["restaurants"], true) => <RestaurantsPage />
     | (["login"], false) => <LoginPage />
     | (["createaccount"], true) => <CreateAccountPage />
     | (["restaurants", id], true) =>
       <RestaurantPage id={int_of_string(id)} />
     | (_, _) => <NotFoundPage />
     }}
  </div>;
};