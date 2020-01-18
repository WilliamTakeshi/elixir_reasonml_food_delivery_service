open Belt;

type state = {
  restaurants: RestaurantData.restaurants,
  loading: bool,
};

type action =
  | Loaded(RestaurantData.restaurants)
  | Loading;

let initialState = {restaurants: [||], loading: false};

let reducer = (state, action) =>
  switch (action) {
  | Loading => {...state, loading: true}
  | Loaded(restaurants) => {restaurants, loading: false}
  };

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState);

  React.useEffect0(() => {
    RestaurantData.fetchRestaurants(payload => dispatch(Loaded(payload)))
    |> ignore;
    None;
  });
  <div>
    <div className="row">
      {if (Array.length(state.restaurants) > 0) {
         state.restaurants
         ->(
             Array.mapWithIndex((index, restaurant) =>
               <RestaurantCard
                 key={string_of_int(restaurant.id)}
                 index
                 restaurant
               />
             )
           )
         ->React.array;
       } else {
         ReasonReact.null;
       }}
    </div>
  </div>;
};