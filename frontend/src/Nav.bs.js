'use strict';

var React = require("react");
var Link$ReasonReactExamples = require("./link.bs.js");

function Nav(Props) {
  var loggedIn = Props.loggedIn;
  return React.createElement("nav", undefined, React.createElement("div", {
                  className: "nav-wrapper red lighten-4"
                }, React.createElement(Link$ReasonReactExamples.make, {
                      href: "/",
                      className: "brand-logo",
                      children: React.createElement("img", {
                            style: {
                              height: "70px",
                              marginLeft: "16px"
                            },
                            src: "img/logo2.png"
                          })
                    }), React.createElement("ul", {
                      className: "right hide-on-med-and-down",
                      id: "nav-mobile"
                    }, loggedIn ? React.createElement("li", undefined, React.createElement(Link$ReasonReactExamples.make, {
                                href: "/logout",
                                children: "Logout"
                              })) : React.createElement("li", undefined, React.createElement(Link$ReasonReactExamples.make, {
                                href: "/login",
                                children: "Login"
                              })), React.createElement("li", undefined, React.createElement(Link$ReasonReactExamples.make, {
                              href: "/restaurants",
                              children: "Restaurants"
                            })), React.createElement("li", undefined, React.createElement(Link$ReasonReactExamples.make, {
                              href: "/orders",
                              children: "Orders"
                            })))));
}

var make = Nav;

exports.make = make;
/* react Not a pure module */
