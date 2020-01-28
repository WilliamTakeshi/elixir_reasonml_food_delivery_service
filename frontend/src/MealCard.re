[@react.component]
let make = (~meal: RestaurantData.meal, ()) => {
  let (qty, setQty) = React.useState(() => "0");

  let handleSubmit = state => {
    OrderData.postOrder(state);
    setQty(_ => "0");
  };

  <div className="col s12 m4">
    <div className="card large">
      <div className="card-image">
        <img src={meal.imgUrl} />
        <span className="card-title"> {React.string(meal.name)} </span>
      </div>
      <div className="card-content">
        <p> {React.string(meal.description)} </p>
        <p> {React.string(Utils.toMoneyFormat(meal.price))} </p>
      </div>
      <div className="card-action">
        <div className="center">
          <input
            type_="number"
            className="validate col s4"
            min=0
            max="20"
            value=qty
            onChange={evt => setQty(ReactEvent.Form.target(evt)##value)}
          />
        </div>
        <div className="right">
          <button
            onClick={_ =>
              handleSubmit(
                Json.Encode.(
                  object_([
                    (
                      "order_meal",
                      object_([
                        ("meal_id", int(meal.id)),
                        ("qty", int(int_of_string(qty))),
                      ]),
                    ),
                  ])
                ),
              )
            }
            className="btn btn-lg btn-primary pull-xs-right green lighten-2">
            {React.string("Order")}
          </button>
        </div>
      </div>
    </div>
  </div>;
};