[@react.component]
let make = (~restaurant: RestaurantData.restaurant, ~index: int, ()) => {
  let stringId = string_of_int(restaurant.id);
  <div className="col s12 m4">
    <div className="card medium">
      <div className="card-image">
        <img src={restaurant.img_url} />
        <span className="card-title"> {Utils.str(restaurant.name)} </span>
      </div>
      <div className="card-content">
        <p> {Utils.str(restaurant.description)} </p>
      </div>
      <div className="card-action">
        <Link href={j|/restaurants/$stringId|j}>
          {Utils.str("Click Here")}
        </Link>
      </div>
    </div>
  </div>;
};