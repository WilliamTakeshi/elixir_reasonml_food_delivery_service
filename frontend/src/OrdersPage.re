open Belt;

type state = {
  orders: OrderData.orders,
  loading: bool,
};

type action =
  | Loaded(OrderData.orders)
  | Loading;

let initialState = {orders: [||], loading: false};

let reducer = (state, action) =>
  switch (action) {
  | Loading => {...state, loading: true}
  | Loaded(orders) => {orders, loading: false}
  };

let makeLine = (order_meal: OrderData.order_meal) => {
  <tr>
    <td> {React.string(order_meal.meal.name)} </td>
    <td> {React.string(string_of_int(order_meal.qty))} </td>
    <td>
      {React.string(
         Utils.toMoneyFormat(order_meal.meal.price * order_meal.qty),
       )}
    </td>
  </tr>;
};

let makeTable = (order: OrderData.order, dispatch) => {
  let nextStatus = Utils.nextStatus(order.status);
  <div>
    <div className="row">
      <h4> {React.string(Utils.translateStatus(order.status))} </h4>
      {if (nextStatus != "error") {
         <button
           className="btn btn-lg btn-primary pull-xs-right green lighten-2"
           onClick={_e => {
             OrderData.updtateOrderStatus(~id=order.id, ~status=nextStatus);
             OrderData.fetchOrders(payload => dispatch(Loaded(payload)))
             |> ignore;
           }}>
           {React.string(
              "Update status to: " ++ Utils.translateStatus(nextStatus),
            )}
         </button>;
       } else {
         <div />;
       }}
    </div>
    <table className="highlight">
      <thead>
        <tr>
          <th width="60%"> {React.string("Name")} </th>
          <th width="20%"> {React.string("Quantity")} </th>
          <th width="20%"> {React.string("Total Price")} </th>
        </tr>
      </thead>
      <tbody>
        {switch (order.orders_meals) {
         | None => ReasonReact.null
         | Some(orders_meals) =>
           orders_meals
           ->(Array.map(ord_meal => makeLine(ord_meal)))
           ->React.array
         }}
      </tbody>
    </table>
  </div>;
};

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState);

  React.useEffect0(() => {
    OrderData.fetchOrders(payload => dispatch(Loaded(payload))) |> ignore;
    None;
  });

  <div className="container">
    {state.orders
     ->(Array.map(order => makeTable(order, dispatch)))
     ->React.array}
  </div>;
};