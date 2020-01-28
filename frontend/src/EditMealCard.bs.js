'use strict';

var React = require("react");
var Link$ReasonReactExamples = require("./link.bs.js");

function EditMealCard(Props) {
  var meal = Props.meal;
  var restaurantId = String(meal.restaurantId);
  var mealId = String(meal.id);
  return React.createElement("div", {
              className: "col s12 m4"
            }, React.createElement("div", {
                  className: "card medium"
                }, React.createElement("div", {
                      className: "card-image"
                    }, React.createElement("img", {
                          src: meal.imgUrl
                        }), React.createElement("span", {
                          className: "card-title"
                        }, meal.name)), React.createElement("div", {
                      className: "card-content"
                    }, React.createElement("p", undefined, meal.description)), React.createElement("div", {
                      className: "card-action"
                    }, React.createElement("div", {
                          className: "center"
                        }, React.createElement(Link$ReasonReactExamples.make, {
                              href: "/restaurants/" + (String(restaurantId) + ("/meals/" + (String(mealId) + "/edit "))),
                              children: React.createElement("button", {
                                    className: "btn btn-lg btn-primary pull-xs-right green lighten-2"
                                  }, "Edit")
                            })))));
}

var make = EditMealCard;

exports.make = make;
/* react Not a pure module */
