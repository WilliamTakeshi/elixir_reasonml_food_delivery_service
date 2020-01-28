'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Belt_Array = require("bs-platform/lib/js/belt_Array.js");
var Caml_int32 = require("bs-platform/lib/js/caml_int32.js");
var Utils$ReasonReactExamples = require("./Utils.bs.js");
var OrderData$ReasonReactExamples = require("./OrderData.bs.js");

var initialState_orders = /* array */[];

var initialState = {
  orders: initialState_orders,
  loading: false
};

function reducer(state, action) {
  if (action) {
    return {
            orders: action[0],
            loading: false
          };
  } else {
    return {
            orders: state.orders,
            loading: true
          };
  }
}

function makeLine(order_meal) {
  return React.createElement("tr", undefined, React.createElement("td", undefined, order_meal.meal.name), React.createElement("td", undefined, String(order_meal.qty)), React.createElement("td", undefined, Utils$ReasonReactExamples.toMoneyFormat(Caml_int32.imul(order_meal.meal.price, order_meal.qty))));
}

function makeTable(order, dispatch) {
  var nextStatus = Utils$ReasonReactExamples.nextStatus(order.status);
  var match = order.orders_meals;
  return React.createElement("div", undefined, React.createElement("div", {
                  className: "row"
                }, React.createElement("h4", undefined, Utils$ReasonReactExamples.translateStatus(order.status)), nextStatus !== "error" ? React.createElement("button", {
                        className: "btn btn-lg btn-primary pull-xs-right green lighten-2",
                        onClick: (function (_e) {
                            OrderData$ReasonReactExamples.updtateOrderStatus(order.id, nextStatus);
                            setTimeout((function (param) {
                                    return OrderData$ReasonReactExamples.fetchOrders((function (payload) {
                                                  return Curry._1(dispatch, /* Loaded */[payload]);
                                                }));
                                  }), 700);
                            return /* () */0;
                          })
                      }, "Update status to: " + Utils$ReasonReactExamples.translateStatus(nextStatus)) : React.createElement("div", undefined)), React.createElement("table", {
                  className: "highlight"
                }, React.createElement("thead", undefined, React.createElement("tr", undefined, React.createElement("th", {
                              width: "60%"
                            }, "Name"), React.createElement("th", {
                              width: "20%"
                            }, "Quantity"), React.createElement("th", {
                              width: "20%"
                            }, "Total Price"))), React.createElement("tbody", undefined, match !== undefined ? Belt_Array.map(match, makeLine) : null)));
}

function OrdersPage(Props) {
  var match = React.useReducer(reducer, initialState);
  var dispatch = match[1];
  React.useEffect((function () {
          OrderData$ReasonReactExamples.fetchOrders((function (payload) {
                  return Curry._1(dispatch, /* Loaded */[payload]);
                }));
          return ;
        }), ([]));
  return React.createElement("div", {
              className: "container"
            }, Belt_Array.map(match[0].orders, (function (order) {
                    return makeTable(order, dispatch);
                  })));
}

var make = OrdersPage;

exports.initialState = initialState;
exports.reducer = reducer;
exports.makeLine = makeLine;
exports.makeTable = makeTable;
exports.make = make;
/* react Not a pure module */
