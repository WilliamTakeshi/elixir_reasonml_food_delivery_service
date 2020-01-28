'use strict';

var React = require("react");
var Link$ReasonReactExamples = require("./link.bs.js");

function RestaurantCard(Props) {
  var restaurant = Props.restaurant;
  var stringId = String(restaurant.id);
  return React.createElement("div", {
              key: String(restaurant.id),
              className: "col s12 m4"
            }, React.createElement("div", {
                  className: "card medium"
                }, React.createElement("div", {
                      className: "card-image"
                    }, React.createElement("img", {
                          src: restaurant.imgUrl
                        }), React.createElement("span", {
                          className: "card-title"
                        }, restaurant.name)), React.createElement("div", {
                      className: "card-content"
                    }, React.createElement("p", undefined, restaurant.description)), React.createElement("div", {
                      className: "card-action"
                    }, React.createElement(Link$ReasonReactExamples.make, {
                          href: "/restaurants/" + (String(stringId) + ""),
                          children: "See more"
                        }))));
}

var make = RestaurantCard;

exports.make = make;
/* react Not a pure module */
