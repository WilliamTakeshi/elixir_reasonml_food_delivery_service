open Belt;

type state = {
  restaurant_with_meal: option(RestaurantData.restaurant_with_meal),
};

type action =
  | Loaded(RestaurantData.restaurant_with_meal);

let initialState = {restaurant_with_meal: None};

let reducer = (_state, action) =>
  switch (action) {
  | Loaded(restaurant_with_meal) => restaurant_with_meal
  };

[@react.component]
let make = (~id) => {
  let handleSubmit = (state: state) => {
    switch (state.restaurant_with_meal) {
    | None => Js.log("error: restaurant not loaded")
    | Some(restaurant) =>
      let body =
        Json.Encode.(
          object_([
            (
              "restaurant",
              object_([
                ("name", string(restaurant.name)),
                ("description", string(restaurant.description)),
              ]),
            ),
          ])
        );
      RestaurantData.updateRestaurant(id, body);
    };
  };

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
         <div>
           <div className="row" />
           <div className="row">
             <div className="input-field col s4 offset-s4">
               <label className="active"> {React.string("Name")} </label>
               <input
                 type_="text"
                 className="validate col s12"
                 value={restaurant.name}
                 onChange={evt =>
                   dispatch(
                     Loaded({
                       ...restaurant,
                       name: ReactEvent.Form.target(evt)##value,
                     }),
                   )
                 }
               />
             </div>
             <div className="input-field col s4 offset-s4">
               <label className="active"> {React.string("Description")} </label>
               <textarea
                 value={restaurant.description}
                 className="materialize-textarea"
                 onChange={evt =>
                   dispatch(
                     Loaded({
                       ...restaurant,
                       description: ReactEvent.Form.target(evt)##value,
                     }),
                   )
                 }
               />
             </div>
             <div className="input-field col s4 offset-s4">
               <button
                 onClick={_evt => handleSubmit(state)}
                 className="btn btn-lg btn-primary pull-xs-right">
                 {React.string("Update restaurant")}
               </button>
             </div>
           </div>
           {restaurant.meals
            ->(
                Array.map(meal =>
                  <EditMealCard key={string_of_int(meal.id)} meal />
                )
              )
            ->React.array}
         </div>
       }}
    </div>
  </div>;
};