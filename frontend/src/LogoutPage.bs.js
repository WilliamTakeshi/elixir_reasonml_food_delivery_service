'use strict';

var React = require("react");
var ReasonReactRouter = require("reason-react/src/ReasonReactRouter.js");
var AuthData$ReasonReactExamples = require("./AuthData.bs.js");

function LogoutPage(Props) {
  React.useEffect((function () {
          AuthData$ReasonReactExamples.logout(/* () */0);
          ReasonReactRouter.push("/login");
          return ;
        }), ([]));
  return React.createElement("div", undefined, "Redirecting...");
}

var make = LogoutPage;

exports.make = make;
/* react Not a pure module */
