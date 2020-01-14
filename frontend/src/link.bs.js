'use strict';

var React = require("react");
var ReasonReactRouter = require("reason-react/src/ReasonReactRouter.js");

function handleClick(href, $$event) {
  if ($$event.defaultPrevented) {
    return 0;
  } else {
    $$event.preventDefault();
    return ReasonReactRouter.push(href);
  }
}

function Link(Props) {
  var href = Props.href;
  var match = Props.className;
  var className = match !== undefined ? match : "";
  var children = Props.children;
  return React.createElement("a", {
              className: className,
              href: href,
              onClick: (function ($$event) {
                  return handleClick(href, $$event);
                })
            }, children);
}

var make = Link;

exports.handleClick = handleClick;
exports.make = make;
/* react Not a pure module */
