[@react.component]
let make = (~restaurant: RestaurantData.restaurant, ()) => {
  let stringId = string_of_int(restaurant.id);
  <div className="col s12 m4" key={string_of_int(restaurant.id)}>
    <div className="card medium">
      <div className="card-image">
        <img src={restaurant.imgUrl} />
        <span className="card-title"> {React.string(restaurant.name)} </span>
      </div>
      <div className="card-content">
        <p> {React.string(restaurant.description)} </p>
      </div>
      <div className="card-action">
        <Link href={j|/restaurants/$stringId|j}>
          {React.string("Click Here")}
        </Link>
      </div>
    </div>
  </div>;
};