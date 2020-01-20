[@react.component]
let make = (~meal: RestaurantData.meal, ~index: int, ()) => {
  let (qty, setQty) = React.useState(() => "0");

  <div className="col s12 m4">
    <div className="card medium">
      <div className="card-image">
        <img src={meal.img_url} />
        <span className="card-title"> {Utils.str(meal.name)} </span>
      </div>
      <div className="card-content">
        <p> {Utils.str(meal.description)} </p>
      </div>
      <div className="card-action">
        <input
          type_="number"
          className="validate col s4 offset-s4"
          min=0
          max="20"
          value=qty
          onChange={evt => setQty(ReactEvent.Form.target(evt)##value)}
        />
      </div>
    </div>
  </div>;
};