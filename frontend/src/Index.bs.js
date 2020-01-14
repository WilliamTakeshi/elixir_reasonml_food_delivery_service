'use strict';

var React = require("react");
var ReactDOMRe = require("reason-react/src/ReactDOMRe.js");
var ReasonReactRouter = require("reason-react/src/ReasonReactRouter.js");
var App$ReasonReactExamples = require("./app.bs.js");

ReactDOMRe.renderToElementWithId(React.createElement(App$ReasonReactExamples.make, { }), "root");

ReasonReactRouter.push("");

/*  Not a pure module */
