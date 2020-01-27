[@react.component]
let make = () => {
  let url = ReasonReact.Router.useUrl();
  <div>
    <Nav loggedIn={AuthData.isUserLoggedIn()} />
    {switch (
       url.path,
       AuthData.isUserLoggedIn(),
       AuthData.getFromStorage("user_role"),
     ) {
     | ([], _, _) => <HomePage />
     | (["login"], _, _) => <LoginPage />
     | (["logout"], _, _) => <LogoutPage />
     | (["createaccount"], false, _) => <CreateAccountPage />
     | (["confirm_email", token], _, _) => <ConfirmEmailPage token />
     | (_, false, _) => <Redirect href="/login" />
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
     | (["restaurants", restaurantId, "blocks"], true, Some("owner")) =>
       <BlocksPage restaurantId />
     | (_, _, _) => <NotFoundPage />
     }}
  </div>;
};