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

let makeTable = (order: OrderData.order) => {
  <div>
    <h4> {React.string(order.status)} </h4>
    <table className="highlight">
      <thead>
        <tr>
          <th> {React.string("Name")} </th>
          <th> {React.string("Quantity")} </th>
          <th> {React.string("Total Price")} </th>
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
    {state.orders->(Array.map(order => makeTable(order)))->React.array}
  </div>;
};