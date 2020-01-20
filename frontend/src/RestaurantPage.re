open Belt;

type state = {
  restaurant_with_meal: option(RestaurantData.restaurant_with_meal),
};

type action =
  | Loaded(RestaurantData.restaurant_with_meal);

let initialState = {restaurant_with_meal: None};

let reducer = (state, action) =>
  switch (action) {
  | Loaded(restaurant_with_meal) => restaurant_with_meal
  };

module Styles = {
  /* Open the Css module, so we can access the style properties below without prefixing them with Css. */
  open Css;

  let sticky_bottom = style([position(sticky), bottom(px(16))]);
};

[@react.component]
let make = (~id) => {
  let (state, dispatch) =
    React.useReducer(
      (_state, action) =>
        switch (action) {
        | Loaded(data) => {restaurant_with_meal: Some(data)}
        },
      initialState,
    );

  React.useEffect0(() => {
    RestaurantData.fetchRestaurantWithMeal(id, data =>
      dispatch(Loaded(data))
    )
    |> ignore;
    None;
  });
  <div className="container">
    <div className="row">
      {switch (state.restaurant_with_meal) {
       | None => ReasonReact.null
       | Some(restaurant) =>
         restaurant.meals
         ->(
             Array.mapWithIndex((index, meal) =>
               <MealCard key={string_of_int(meal.id)} index meal />
             )
           )
         ->React.array
       }}
    </div>
    <div className=Styles.sticky_bottom>
      <div className="center">
        <button
          onClick=Js.log className="btn btn-lg btn-primary pull-xs-right">
          {Utils.str("Order")}
        </button>
      </div>
    </div>
  </div>;
};