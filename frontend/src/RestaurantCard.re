[@react.component]
let make = (~restaurant: RestaurantData.restaurant, ~index: int, ()) => {
  <div className="col s12 m4">
    <div className="card">
      <div className="card-image">
        <img src={restaurant.img_url} />
        <span className="card-title"> {Utils.str(restaurant.name)} </span>
      </div>
      <div className="card-content">
        <p> {Utils.str(restaurant.description)} </p>
      </div>
      <div className="card-action">
        <Link href="/"> {Utils.str("Click here")} </Link>
      </div>
    </div>
  </div>;
};