'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Caml_format = require("bs-platform/lib/js/caml_format.js");
var Json_encode = require("@glennsl/bs-json/src/Json_encode.bs.js");
var Utils$ReasonReactExamples = require("./Utils.bs.js");
var OrderData$ReasonReactExamples = require("./OrderData.bs.js");

function MealCard(Props) {
  var meal = Props.meal;
  var match = React.useState((function () {
          return "0";
        }));
  var setQty = match[1];
  var qty = match[0];
  return React.createElement("div", {
              className: "col s12 m4"
            }, React.createElement("div", {
                  className: "card large"
                }, React.createElement("div", {
                      className: "card-image"
                    }, React.createElement("img", {
                          src: meal.imgUrl
                        }), React.createElement("span", {
                          className: "card-title"
                        }, meal.name)), React.createElement("div", {
                      className: "card-content"
                    }, React.createElement("p", undefined, meal.description), React.createElement("p", undefined, Utils$ReasonReactExamples.toMoneyFormat(meal.price))), React.createElement("div", {
                      className: "card-action"
                    }, React.createElement("div", {
                          className: "center"
                        }, React.createElement("input", {
                              className: "validate col s4",
                              max: "20",
                              min: 0,
                              type: "number",
                              value: qty,
                              onChange: (function (evt) {
                                  return Curry._1(setQty, evt.target.value);
                                })
                            })), React.createElement("div", {
                          className: "right"
                        }, React.createElement("button", {
                              className: "btn btn-lg btn-primary pull-xs-right green lighten-2",
                              onClick: (function (param) {
                                  var state = Json_encode.object_(/* :: */[
                                        /* tuple */[
                                          "order_meal",
                                          Json_encode.object_(/* :: */[
                                                /* tuple */[
                                                  "meal_id",
                                                  meal.id
                                                ],
                                                /* :: */[
                                                  /* tuple */[
                                                    "qty",
                                                    Caml_format.caml_int_of_string(qty)
                                                  ],
                                                  /* [] */0
                                                ]
                                              ])
                                        ],
                                        /* [] */0
                                      ]);
                                  OrderData$ReasonReactExamples.postOrder(state);
                                  return Curry._1(setQty, (function (param) {
                                                return "0";
                                              }));
                                })
                            }, "Order")))));
}

var make = MealCard;

exports.make = make;
/* react Not a pure module */
