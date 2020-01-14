'use strict';

var React = require("react");
var ReasonReactRouter = require("reason-react/src/ReasonReactRouter.js");
var NotFound$ReasonReactExamples = require("./NotFound.bs.js");

function App(Props) {
  var url = ReasonReactRouter.useUrl(undefined, /* () */0);
  var match = url.path;
  if (match) {
    return React.createElement(NotFound$ReasonReactExamples.make, { });
  } else {
    return React.createElement(NotFound$ReasonReactExamples.make, { });
  }
}

var make = App;

exports.make = make;
/* react Not a pure module */
