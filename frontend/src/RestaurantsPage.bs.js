'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Belt_Array = require("bs-platform/lib/js/belt_Array.js");
var RestaurantCard$ReasonReactExamples = require("./RestaurantCard.bs.js");
var RestaurantData$ReasonReactExamples = require("./RestaurantData.bs.js");

var initialState_restaurants = /* array */[];

var initialState = {
  restaurants: initialState_restaurants,
  loading: false
};

function reducer(state, action) {
  if (action) {
    return {
            restaurants: action[0],
            loading: false
          };
  } else {
    return {
            restaurants: state.restaurants,
            loading: true
          };
  }
}

function RestaurantsPage(Props) {
  var match = React.useReducer(reducer, initialState);
  var dispatch = match[1];
  var state = match[0];
  React.useEffect((function () {
          RestaurantData$ReasonReactExamples.fetchRestaurants((function (payload) {
                  return Curry._1(dispatch, /* Loaded */[payload]);
                }));
          return ;
        }), ([]));
  return React.createElement("div", {
              className: "container"
            }, React.createElement("div", {
                  className: "row"
                }, state.restaurants.length !== 0 ? Belt_Array.mapWithIndex(state.restaurants, (function (index, restaurant) {
                          return React.createElement(RestaurantCard$ReasonReactExamples.make, {
                                      restaurant: restaurant,
                                      index: index,
                                      key: String(restaurant.id)
                                    });
                        })) : null));
}

var make = RestaurantsPage;

exports.initialState = initialState;
exports.reducer = reducer;
exports.make = make;
/* react Not a pure module */
