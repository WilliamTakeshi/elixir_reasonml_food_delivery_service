'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var Fetch = require("bs-fetch/src/Fetch.js");
var Caml_option = require("bs-platform/lib/js/caml_option.js");
var Json_decode = require("@glennsl/bs-json/src/Json_decode.bs.js");
var AuthData$ReasonReactExamples = require("./AuthData.bs.js");
var RestaurantData$ReasonReactExamples = require("./RestaurantData.bs.js");

var apiBaseUrl = "http://localhost:4000";

function order_meal(json) {
  return {
          id: Json_decode.field("id", Json_decode.$$int, json),
          meal: Json_decode.field("meal", RestaurantData$ReasonReactExamples.Decode.meal, json),
          inserted_at: Json_decode.optional((function (param) {
                  return Json_decode.field("inserted_at", Json_decode.date, param);
                }), json),
          updated_at: Json_decode.optional((function (param) {
                  return Json_decode.field("updated_at", Json_decode.date, param);
                }), json),
          meal_id: Json_decode.field("meal_id", Json_decode.$$int, json),
          order_id: Json_decode.field("order_id", Json_decode.$$int, json),
          qty: Json_decode.field("qty", Json_decode.$$int, json)
        };
}

function order(json) {
  return {
          id: Json_decode.field("id", Json_decode.$$int, json),
          canceled_date: Json_decode.optional((function (param) {
                  return Json_decode.field("canceled_date", Json_decode.date, param);
                }), json),
          delivered_date: Json_decode.optional((function (param) {
                  return Json_decode.field("delivered_date", Json_decode.date, param);
                }), json),
          in_route_date: Json_decode.optional((function (param) {
                  return Json_decode.field("in_route_date", Json_decode.date, param);
                }), json),
          inserted_at: Json_decode.optional((function (param) {
                  return Json_decode.field("inserted_at", Json_decode.date, param);
                }), json),
          updated_at: Json_decode.optional((function (param) {
                  return Json_decode.field("updated_at", Json_decode.date, param);
                }), json),
          placed_date: Json_decode.optional((function (param) {
                  return Json_decode.field("placed_date", Json_decode.date, param);
                }), json),
          processing_date: Json_decode.optional((function (param) {
                  return Json_decode.field("processing_date", Json_decode.date, param);
                }), json),
          received_date: Json_decode.optional((function (param) {
                  return Json_decode.field("received_date", Json_decode.date, param);
                }), json),
          restaurant_id: Json_decode.field("restaurant_id", Json_decode.$$int, json),
          status: Json_decode.field("status", Json_decode.string, json),
          user_id: Json_decode.field("user_id", Json_decode.$$int, json),
          orders_meals: Json_decode.optional((function (param) {
                  return Json_decode.field("orders_meals", (function (param) {
                                return Json_decode.array(order_meal, param);
                              }), param);
                }), json)
        };
}

function orders(json) {
  return Json_decode.array(order, json);
}

var Decode = {
  order_meal: order_meal,
  order: order,
  orders: orders
};

function fetchOrders(callback) {
  fetch("" + (String(apiBaseUrl) + "/api/v1/orders"), Fetch.RequestInit.make(/* Get */0, {
                  Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt")
                }, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          var orders$1 = Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], orders)(json);
          Curry._1(callback, orders$1);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function postOrder(body) {
  fetch("" + (String(apiBaseUrl) + "/api/v1/orders"), Fetch.RequestInit.make(/* Post */2, {
                  "Content-Type": "application/json",
                  Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt")
                }, Caml_option.some(JSON.stringify(body)), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], order)(json);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function updtateOrderStatus(id, status) {
  fetch("" + (String(apiBaseUrl) + ("/api/v1/orders/" + (String(id) + ("/" + (String(status) + ""))))), Fetch.RequestInit.make(/* Post */2, {
                  "Content-Type": "application/json",
                  Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt")
                }, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], order)(json);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

exports.apiBaseUrl = apiBaseUrl;
exports.Decode = Decode;
exports.fetchOrders = fetchOrders;
exports.postOrder = postOrder;
exports.updtateOrderStatus = updtateOrderStatus;
/* AuthData-ReasonReactExamples Not a pure module */
