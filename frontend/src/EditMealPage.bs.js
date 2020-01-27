'use strict';

var Block = require("bs-platform/lib/js/block.js");
var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Json_encode = require("@glennsl/bs-json/src/Json_encode.bs.js");
var RestaurantData$ReasonReactExamples = require("./RestaurantData.bs.js");

var initialState = {
  meal: undefined
};

function reducer(state, action) {
  var match = state.meal;
  if (action.tag) {
    if (match !== undefined) {
      var meal = match;
      switch (action.tag | 0) {
        case /* UpdatePrice */1 :
            return {
                    meal: {
                      active: meal.active,
                      id: meal.id,
                      description: meal.description,
                      imgUrl: meal.imgUrl,
                      name: meal.name,
                      price: action[0],
                      restaurantId: meal.restaurantId
                    }
                  };
        case /* UpdateImgUrl */2 :
            return {
                    meal: {
                      active: meal.active,
                      id: meal.id,
                      description: meal.description,
                      imgUrl: action[0],
                      name: meal.name,
                      price: meal.price,
                      restaurantId: meal.restaurantId
                    }
                  };
        case /* UpdateDescription */3 :
            return {
                    meal: {
                      active: meal.active,
                      id: meal.id,
                      description: action[0],
                      imgUrl: meal.imgUrl,
                      name: meal.name,
                      price: meal.price,
                      restaurantId: meal.restaurantId
                    }
                  };
        case /* UpdateName */4 :
            return {
                    meal: {
                      active: meal.active,
                      id: meal.id,
                      description: meal.description,
                      imgUrl: meal.imgUrl,
                      name: action[0],
                      price: meal.price,
                      restaurantId: meal.restaurantId
                    }
                  };
        
      }
    } else {
      return {
              meal: undefined
            };
    }
  } else {
    return {
            meal: action[0]
          };
  }
}

function EditMealPage(Props) {
  var mealId = Props.mealId;
  var restaurantId = Props.restaurantId;
  var match = React.useReducer(reducer, initialState);
  var dispatch = match[1];
  var state = match[0];
  console.log(state);
  React.useEffect((function () {
          RestaurantData$ReasonReactExamples.fetchMeal(mealId, restaurantId, (function (data) {
                  return Curry._1(dispatch, /* Loaded */Block.__(0, [data]));
                }));
          return ;
        }), ([]));
  var match$1 = state.meal;
  var tmp;
  if (match$1 !== undefined) {
    var restaurant = match$1;
    tmp = React.createElement("div", undefined, React.createElement("div", {
              className: "row"
            }), React.createElement("div", {
              className: "row"
            }, React.createElement("div", {
                  className: "input-field col s12"
                }, React.createElement("label", {
                      className: "active"
                    }, "Name"), React.createElement("input", {
                      className: "validate col s12",
                      type: "text",
                      value: restaurant.name,
                      onChange: (function (evt) {
                          return Curry._1(dispatch, /* UpdateName */Block.__(4, [evt.target.value]));
                        })
                    })), React.createElement("div", {
                  className: "input-field col s12"
                }, React.createElement("label", {
                      className: "active"
                    }, "Description"), React.createElement("textarea", {
                      className: "materialize-textarea",
                      value: restaurant.description,
                      onChange: (function (evt) {
                          return Curry._1(dispatch, /* UpdateDescription */Block.__(3, [evt.target.value]));
                        })
                    })), React.createElement("div", {
                  className: "input-field col s12"
                }, React.createElement("label", {
                      className: "active"
                    }, "Image URL"), React.createElement("input", {
                      className: "validate col s12",
                      type: "text",
                      value: restaurant.imgUrl,
                      onChange: (function (evt) {
                          return Curry._1(dispatch, /* UpdateImgUrl */Block.__(2, [evt.target.value]));
                        })
                    })), React.createElement("div", {
                  className: "input-field col s12"
                }, React.createElement("label", {
                      className: "active"
                    }, "Price"), React.createElement("input", {
                      className: "validate col s12",
                      min: 0,
                      type: "number",
                      value: String(restaurant.price),
                      onChange: (function (evt) {
                          return Curry._1(dispatch, /* UpdatePrice */Block.__(1, [evt.target.value]));
                        })
                    })), React.createElement("div", {
                  className: "input-field col s4 offset-s4"
                }, React.createElement("button", {
                      className: "btn btn-lg btn-primary pull-xs-right",
                      onClick: (function (_evt) {
                          var state$1 = state;
                          var match = state$1.meal;
                          if (match !== undefined) {
                            var meal = match;
                            var body = Json_encode.object_(/* :: */[
                                  /* tuple */[
                                    "meal",
                                    Json_encode.object_(/* :: */[
                                          /* tuple */[
                                            "name",
                                            meal.name
                                          ],
                                          /* :: */[
                                            /* tuple */[
                                              "description",
                                              meal.description
                                            ],
                                            /* :: */[
                                              /* tuple */[
                                                "price",
                                                meal.price
                                              ],
                                              /* :: */[
                                                /* tuple */[
                                                  "img_url",
                                                  meal.imgUrl
                                                ],
                                                /* [] */0
                                              ]
                                            ]
                                          ]
                                        ])
                                  ],
                                  /* [] */0
                                ]);
                            return RestaurantData$ReasonReactExamples.updateMeal(mealId, restaurantId, body);
                          } else {
                            console.log("error: restaurant not loaded");
                            return /* () */0;
                          }
                        })
                    }, "Update meal"))));
  } else {
    tmp = null;
  }
  return React.createElement("div", {
              className: "container"
            }, React.createElement("div", {
                  className: "row"
                }, tmp));
}

var make = EditMealPage;

exports.initialState = initialState;
exports.reducer = reducer;
exports.make = make;
/* react Not a pure module */
