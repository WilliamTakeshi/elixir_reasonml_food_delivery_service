type state = {meal: option(RestaurantData.meal)};

type action =
  | Loaded(RestaurantData.meal)
  | UpdatePrice(int)
  | UpdateImgUrl(string)
  | UpdateDescription(string)
  | UpdateName(string);

let initialState: state = {meal: None};

let reducer = (state: state, action: action): state =>
  switch (state.meal, action) {
  | (_, Loaded(value)) => {meal: Some(value)}
  | (None, _) => {meal: None}
  | (Some(meal), UpdatePrice(price)) => {meal: Some({...meal, price})}
  | (Some(meal), UpdateImgUrl(imgUrl)) => {meal: Some({...meal, imgUrl})}
  | (Some(meal), UpdateDescription(description)) => {
      meal: Some({...meal, description}),
    }
  | (Some(meal), UpdateName(name)) => {meal: Some({...meal, name})}
  };

[@react.component]
let make = (~mealId, ~restaurantId, ()) => {
  let handleSubmit = (state: state) => {
    switch (state.meal) {
    | None => Js.log("error: restaurant not loaded")
    | Some(meal) =>
      let body =
        Json.Encode.(
          object_([
            (
              "meal",
              object_([
                ("name", string(meal.name)),
                ("description", string(meal.description)),
                ("price", int(meal.price)),
                ("img_url", string(meal.imgUrl)),
              ]),
            ),
          ])
        );
      RestaurantData.updateMeal(mealId, restaurantId, body);
    };
  };

  let (state, dispatch) = React.useReducer(reducer, initialState);

  Js.log(state);

  React.useEffect0(() => {
    RestaurantData.fetchMeal(mealId, restaurantId, data =>
      dispatch(Loaded(data))
    )
    |> ignore;
    None;
  });
  <div className="container">
    <div className="row">
      {switch (state.meal) {
       | None => ReasonReact.null
       | Some(restaurant) =>
         <div>
           <div className="row" />
           <div className="row">
             <div className="input-field col s12">
               <label className="active"> {React.string("Name")} </label>
               <input
                 type_="text"
                 className="validate col s12"
                 value={restaurant.name}
                 onChange={evt =>
                   dispatch(UpdateName(ReactEvent.Form.target(evt)##value))
                 }
               />
             </div>
             <div className="input-field col s12">
               <label className="active">
                 {React.string("Description")}
               </label>
               <textarea
                 value={restaurant.description}
                 className="materialize-textarea"
                 onChange={evt =>
                   dispatch(
                     UpdateDescription(ReactEvent.Form.target(evt)##value),
                   )
                 }
               />
             </div>
             <div className="input-field col s12">
               <label className="active"> {React.string("Image URL")} </label>
               <input
                 type_="text"
                 className="validate col s12"
                 value={restaurant.imgUrl}
                 onChange={evt =>
                   dispatch(
                     UpdateImgUrl(ReactEvent.Form.target(evt)##value),
                   )
                 }
               />
             </div>
             <div className="input-field col s12">
               <label className="active"> {React.string("Price")} </label>
               <input
                 type_="number"
                 className="validate col s12"
                 min=0
                 value={string_of_int(restaurant.price)}
                 onChange={evt =>
                   dispatch(UpdatePrice(ReactEvent.Form.target(evt)##value))
                 }
               />
             </div>
             <div className="input-field col s4 offset-s4">
               <button
                 onClick={_evt => handleSubmit(state)}
                 className="btn btn-lg btn-primary pull-xs-right green lighten-2">
                 {React.string("Update meal")}
               </button>
             </div>
           </div>
         </div>
       }}
    </div>
  </div>;
};