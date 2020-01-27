'use strict';

var React = require("react");
var ReasonReactRouter = require("reason-react/src/ReasonReactRouter.js");

function Redirect(Props) {
  var href = Props.href;
  React.useEffect((function () {
          ReasonReactRouter.push(href);
          return ;
        }), ([]));
  return React.createElement("div", undefined, "Redirecting...");
}

var make = Redirect;

exports.make = make;
/* react Not a pure module */
