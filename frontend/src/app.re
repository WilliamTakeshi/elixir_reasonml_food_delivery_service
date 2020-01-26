/*
    TODO
    Add check is logged in
    router if logged incorrectly
 */

[@react.component]
let make = () => {
  let url = ReasonReact.Router.useUrl();
  if (AuthData.isUserLoggedIn()
      && AuthData.getFromStorage("user_role") == None) {
    AuthData.me();
  };

  <div>
    <Nav />
    {switch (
       url.path,
       AuthData.isUserLoggedIn(),
       AuthData.getFromStorage("user_role"),
     ) {
     | (["login"], false, _) => <LoginPage />
     | (["createaccount"], false, _) => <CreateAccountPage />
     | (["confirm_email", token], _, _) => <ConfirmEmailPage token />
     | (_, false, _) => <Redirect href="/login" />
     | ([], true, _)
     | (["restaurants"], true, _) => <RestaurantsPage />
     | (["orders"], true, _) => <OrdersPage />
     | (["restaurants", id], true, _) =>
       <RestaurantPage id={int_of_string(id)} />
     | (["edit", "restaurants", id], true, Some("owner")) =>
       <EditRestaurantPage id={int_of_string(id)} />
     | (
         ["edit", "restaurants", restaurantId, "meals", mealId],
         true,
         Some("owner"),
       ) =>
       <EditMealPage
         restaurantId={int_of_string(restaurantId)}
         mealId={int_of_string(mealId)}
       />
     | (_, _, _) => <NotFoundPage />
     }}
  </div>;
};