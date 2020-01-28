[@react.component]
let make = (~meal: RestaurantData.meal, ()) => {
  let restaurantId = string_of_int(meal.restaurantId);
  let mealId = string_of_int(meal.id);

  <div className="col s12 m4">
    <div className="card medium">
      <div className="card-image">
        <img src={meal.imgUrl} />
        <span className="card-title"> {React.string(meal.name)} </span>
      </div>
      <div className="card-content">
        <p> {React.string(meal.description)} </p>
      </div>
      <div className="card-action">
        <div className="center">
          <Link href={j|/edit/restaurants/$restaurantId/meals/$mealId |j}>
            <button
              className="btn btn-lg btn-primary pull-xs-right green lighten-2">
              {React.string("Edit")}
            </button>
          </Link>
        </div>
      </div>
    </div>
  </div>;
};