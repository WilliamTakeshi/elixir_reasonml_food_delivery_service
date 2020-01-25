/*
    TODO
    Add check is logged in
    router if logged incorrectly
 */

[@react.component]
let make = () => {
  let url = ReasonReact.Router.useUrl();
  // if (!AuthData.isUserLoggedIn() && url.path != ["login"]) {
  //   ReasonReact.Router.push("/login");
  // };

  <div>
    <Nav />
    {switch (url.path, AuthData.isUserLoggedIn()) {
     | ([], true)
     | (["restaurants"], true) => <RestaurantsPage />
     | (["login"], _) => <LoginPage />
     | (["createaccount"], false) => <CreateAccountPage />
     | (["confirm_email", token], _) => <ConfirmEmailPage token />
     | (["orders"], true) => <OrdersPage />
     | (["restaurants", id], true) =>
       <RestaurantPage id={int_of_string(id)} />
     | (["edit", "restaurants", id], true) =>
       <EditRestaurantPage id={int_of_string(id)} />
     | (["edit", "restaurants", restaurantId, "meals", mealId], true) =>
       <EditMealPage
         restaurantId={int_of_string(restaurantId)}
         mealId={int_of_string(mealId)}
       />
     | (_, _) => <NotFoundPage />
     }}
  </div>;
};