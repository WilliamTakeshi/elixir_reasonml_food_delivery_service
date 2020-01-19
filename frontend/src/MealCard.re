[@react.component]
let make = (~meal: RestaurantData.meal, ~index: int, ()) => {
  let (qty, setQty) = React.useState(() => "1");

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
          className="validate col s3"
          min=1
          max="20"
          value=qty
          onChange={evt => setQty(ReactEvent.Form.target(evt)##value)}
        />
        <button
          className="btn waves-effect waves-light col s3 right"
          type_="submit"
          name="action">
          {Utils.str("Order")}
        </button>
      </div>
    </div>
  </div>;
};