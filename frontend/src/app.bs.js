'use strict';

var React = require("react");
var ReasonReactRouter = require("reason-react/src/ReasonReactRouter.js");
var Login$ReasonReactExamples = require("./Login.bs.js");
var NotFound$ReasonReactExamples = require("./NotFound.bs.js");
var CreateAccount$ReasonReactExamples = require("./CreateAccount.bs.js");

function App(Props) {
  var url = ReasonReactRouter.useUrl(undefined, /* () */0);
  var match = url.path;
  if (match) {
    if (match[0] === "createaccount") {
      if (match[1]) {
        return React.createElement(NotFound$ReasonReactExamples.make, { });
      } else {
        return React.createElement(CreateAccount$ReasonReactExamples.make, { });
      }
    } else {
      return React.createElement(NotFound$ReasonReactExamples.make, { });
    }
  } else {
    return React.createElement(Login$ReasonReactExamples.make, { });
  }
}

var make = App;

exports.make = make;
/* react Not a pure module */
