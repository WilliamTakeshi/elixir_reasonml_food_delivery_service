'use strict';

var React = require("react");
var AuthData$ReasonReactExamples = require("./AuthData.bs.js");

function ConfirmEmailPage(Props) {
  var token = Props.token;
  var match = React.useState((function () {
          return "";
        }));
  var setMessage = match[1];
  React.useEffect((function () {
          AuthData$ReasonReactExamples.confirmEmail(token, setMessage);
          return ;
        }), ([]));
  return React.createElement("div", {
              className: "container "
            }, React.createElement("div", {
                  className: "col s6 offset-s6"
                }, React.createElement("p", undefined, match[0])));
}

var make = ConfirmEmailPage;

exports.make = make;
/* react Not a pure module */
