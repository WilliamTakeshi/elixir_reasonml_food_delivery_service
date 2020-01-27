'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Belt_Array = require("bs-platform/lib/js/belt_Array.js");
var MealCard$ReasonReactExamples = require("./MealCard.bs.js");
var RestaurantData$ReasonReactExamples = require("./RestaurantData.bs.js");

var initialState = {
  restaurant_with_meal: undefined
};

function reducer(state, action) {
  return action[0];
}

function RestaurantPage(Props) {
  var id = Props.id;
  var match = React.useReducer((function (_state, action) {
          return {
                  restaurant_with_meal: action[0]
                };
        }), initialState);
  var dispatch = match[1];
  React.useEffect((function () {
          RestaurantData$ReasonReactExamples.fetchRestaurantWithMeal(id, (function (data) {
                  return Curry._1(dispatch, /* Loaded */[data]);
                }));
          return ;
        }), ([]));
  var match$1 = match[0].restaurant_with_meal;
  return React.createElement("div", {
              className: "container"
            }, React.createElement("div", {
                  className: "row"
                }, match$1 !== undefined ? Belt_Array.map(match$1.meals, (function (meal) {
                          return React.createElement(MealCard$ReasonReactExamples.make, {
                                      meal: meal,
                                      key: String(meal.id)
                                    });
                        })) : null));
}

var make = RestaurantPage;

exports.initialState = initialState;
exports.reducer = reducer;
exports.make = make;
/* react Not a pure module */
