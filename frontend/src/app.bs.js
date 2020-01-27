'use strict';

var React = require("react");
var Caml_format = require("bs-platform/lib/js/caml_format.js");
var ReasonReactRouter = require("reason-react/src/ReasonReactRouter.js");
var Nav$ReasonReactExamples = require("./Nav.bs.js");
var AuthData$ReasonReactExamples = require("./AuthData.bs.js");
var HomePage$ReasonReactExamples = require("./HomePage.bs.js");
var Redirect$ReasonReactExamples = require("./Redirect.bs.js");
var LoginPage$ReasonReactExamples = require("./LoginPage.bs.js");
var BlocksPage$ReasonReactExamples = require("./BlocksPage.bs.js");
var OrdersPage$ReasonReactExamples = require("./OrdersPage.bs.js");
var EditMealPage$ReasonReactExamples = require("./EditMealPage.bs.js");
var NotFoundPage$ReasonReactExamples = require("./NotFoundPage.bs.js");
var RestaurantPage$ReasonReactExamples = require("./RestaurantPage.bs.js");
var RestaurantsPage$ReasonReactExamples = require("./RestaurantsPage.bs.js");
var ConfirmEmailPage$ReasonReactExamples = require("./ConfirmEmailPage.bs.js");
var CreateAccountPage$ReasonReactExamples = require("./CreateAccountPage.bs.js");
var EditRestaurantPage$ReasonReactExamples = require("./EditRestaurantPage.bs.js");

function App(Props) {
  var url = ReasonReactRouter.useUrl(undefined, /* () */0);
  var match = url.path;
  var match$1 = AuthData$ReasonReactExamples.isUserLoggedIn(/* () */0);
  var match$2 = AuthData$ReasonReactExamples.getFromStorage("user_role");
  var tmp;
  var exit = 0;
  var exit$1 = 0;
  if (match) {
    switch (match[0]) {
      case "confirm_email" :
          var match$3 = match[1];
          if (match$3 && !match$3[1]) {
            tmp = React.createElement(ConfirmEmailPage$ReasonReactExamples.make, {
                  token: match$3[0]
                });
          } else {
            exit$1 = 2;
          }
          break;
      case "createaccount" :
          if (match[1]) {
            exit$1 = 2;
          } else if (match$1) {
            exit = 1;
          } else {
            tmp = React.createElement(CreateAccountPage$ReasonReactExamples.make, { });
          }
          break;
      case "edit" :
          var match$4 = match[1];
          if (match$4 && match$4[0] === "restaurants") {
            var match$5 = match$4[1];
            if (match$5) {
              var match$6 = match$5[1];
              var id = match$5[0];
              if (match$6) {
                if (match$6[0] === "meals") {
                  var match$7 = match$6[1];
                  if (match$7 && !(match$7[1] || !match$1)) {
                    if (match$2 === "owner") {
                      tmp = React.createElement(EditMealPage$ReasonReactExamples.make, {
                            mealId: Caml_format.caml_int_of_string(match$7[0]),
                            restaurantId: Caml_format.caml_int_of_string(id)
                          });
                    } else {
                      exit = 1;
                    }
                  } else {
                    exit$1 = 2;
                  }
                } else {
                  exit$1 = 2;
                }
              } else if (match$1) {
                if (match$2 === "owner") {
                  tmp = React.createElement(EditRestaurantPage$ReasonReactExamples.make, {
                        id: Caml_format.caml_int_of_string(id)
                      });
                } else {
                  exit = 1;
                }
              } else {
                exit$1 = 2;
              }
            } else {
              exit$1 = 2;
            }
          } else {
            exit$1 = 2;
          }
          break;
      case "login" :
          if (match[1]) {
            exit$1 = 2;
          } else {
            tmp = React.createElement(LoginPage$ReasonReactExamples.make, { });
          }
          break;
      case "orders" :
          if (match[1] || !match$1) {
            exit$1 = 2;
          } else {
            tmp = React.createElement(OrdersPage$ReasonReactExamples.make, { });
          }
          break;
      case "restaurants" :
          var match$8 = match[1];
          if (match$8) {
            var match$9 = match$8[1];
            var id$1 = match$8[0];
            if (match$9) {
              if (match$9[0] === "blocks" && !(match$9[1] || !match$1)) {
                if (match$2 === "owner") {
                  tmp = React.createElement(BlocksPage$ReasonReactExamples.make, {
                        restaurantId: id$1
                      });
                } else {
                  exit = 1;
                }
              } else {
                exit$1 = 2;
              }
            } else if (match$1) {
              tmp = React.createElement(RestaurantPage$ReasonReactExamples.make, {
                    id: Caml_format.caml_int_of_string(id$1)
                  });
            } else {
              exit$1 = 2;
            }
          } else if (match$1) {
            tmp = React.createElement(RestaurantsPage$ReasonReactExamples.make, { });
          } else {
            exit$1 = 2;
          }
          break;
      default:
        exit$1 = 2;
    }
  } else {
    tmp = React.createElement(HomePage$ReasonReactExamples.make, { });
  }
  if (exit$1 === 2) {
    if (match$1) {
      exit = 1;
    } else {
      tmp = React.createElement(Redirect$ReasonReactExamples.make, {
            href: "/login"
          });
    }
  }
  if (exit === 1) {
    tmp = React.createElement(NotFoundPage$ReasonReactExamples.make, { });
  }
  return React.createElement("div", undefined, React.createElement(Nav$ReasonReactExamples.make, { }), tmp);
}

var make = App;

exports.make = make;
/* react Not a pure module */
