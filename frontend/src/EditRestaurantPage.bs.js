'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Belt_Array = require("bs-platform/lib/js/belt_Array.js");
var Json_encode = require("@glennsl/bs-json/src/Json_encode.bs.js");
var EditMealCard$ReasonReactExamples = require("./EditMealCard.bs.js");
var RestaurantData$ReasonReactExamples = require("./RestaurantData.bs.js");

var initialState = {
  restaurant_with_meal: undefined
};

function reducer(_state, action) {
  return action[0];
}

function EditRestaurantPage(Props) {
  var id = Props.id;
  var match = React.useReducer((function (_state, action) {
          return {
                  restaurant_with_meal: action[0]
                };
        }), initialState);
  var dispatch = match[1];
  var state = match[0];
  React.useEffect((function () {
          RestaurantData$ReasonReactExamples.fetchRestaurantWithMeal(id, (function (data) {
                  return Curry._1(dispatch, /* Loaded */[data]);
                }));
          return ;
        }), ([]));
  var match$1 = state.restaurant_with_meal;
  var tmp;
  if (match$1 !== undefined) {
    var restaurant = match$1;
    tmp = React.createElement("div", undefined, React.createElement("div", {
              className: "row"
            }), React.createElement("div", {
              className: "row"
            }, React.createElement("div", {
                  className: "input-field col s4 offset-s4"
                }, React.createElement("label", {
                      className: "active"
                    }, "Name"), React.createElement("input", {
                      className: "validate col s12",
                      type: "text",
                      value: restaurant.name,
                      onChange: (function (evt) {
                          return Curry._1(dispatch, /* Loaded */[{
                                        description: restaurant.description,
                                        id: restaurant.id,
                                        imgUrl: restaurant.imgUrl,
                                        name: evt.target.value,
                                        meals: restaurant.meals
                                      }]);
                        })
                    })), React.createElement("div", {
                  className: "input-field col s4 offset-s4"
                }, React.createElement("label", {
                      className: "active"
                    }, "Description"), React.createElement("textarea", {
                      className: "materialize-textarea",
                      value: restaurant.description,
                      onChange: (function (evt) {
                          return Curry._1(dispatch, /* Loaded */[{
                                        description: evt.target.value,
                                        id: restaurant.id,
                                        imgUrl: restaurant.imgUrl,
                                        name: restaurant.name,
                                        meals: restaurant.meals
                                      }]);
                        })
                    })), React.createElement("div", {
                  className: "input-field col s4 offset-s4"
                }, React.createElement("button", {
                      className: "btn btn-lg btn-primary pull-xs-right green lighten-2",
                      onClick: (function (_evt) {
                          var state$1 = state;
                          var match = state$1.restaurant_with_meal;
                          if (match !== undefined) {
                            var restaurant = match;
                            var body = Json_encode.object_(/* :: */[
                                  /* tuple */[
                                    "restaurant",
                                    Json_encode.object_(/* :: */[
                                          /* tuple */[
                                            "name",
                                            restaurant.name
                                          ],
                                          /* :: */[
                                            /* tuple */[
                                              "description",
                                              restaurant.description
                                            ],
                                            /* [] */0
                                          ]
                                        ])
                                  ],
                                  /* [] */0
                                ]);
                            return RestaurantData$ReasonReactExamples.updateRestaurant(id, body);
                          } else {
                            console.log("error: restaurant not loaded");
                            return /* () */0;
                          }
                        })
                    }, "Update restaurant"))), Belt_Array.map(restaurant.meals, (function (meal) {
                return React.createElement(EditMealCard$ReasonReactExamples.make, {
                            meal: meal,
                            key: String(meal.id)
                          });
              })));
  } else {
    tmp = null;
  }
  return React.createElement("div", {
              className: "container"
            }, React.createElement("div", {
                  className: "row"
                }, tmp));
}

var make = EditRestaurantPage;

exports.initialState = initialState;
exports.reducer = reducer;
exports.make = make;
/* react Not a pure module */
