'use strict';

var React = require("react");
var ReasonReactRouter = require("reason-react/src/ReasonReactRouter.js");

function str(prim) {
  return prim;
}

function Login(Props) {
  return React.createElement("div", {
              className: "auth-page"
            }, React.createElement("div", {
                  className: "container page"
                }, React.createElement("div", {
                      className: "row"
                    }, React.createElement("div", {
                          className: "col-md-6 offset-md-3 col-xs-12"
                        }, React.createElement("h1", {
                              className: "text-xs-center"
                            }, "Sign in"), React.createElement("p", {
                              className: "text-xs-center"
                            }, React.createElement("a", {
                                  href: "",
                                  onClick: (function (_e) {
                                      return ReasonReactRouter.push("sign-in");
                                    })
                                }, "Need an account?"), React.createElement("form", undefined, React.createElement("fieldset", {
                                      className: "form-group"
                                    }, React.createElement("input", {
                                          className: "form-control form-control-lg",
                                          placeholder: "Email",
                                          type: "text"
                                        })), React.createElement("fieldset", {
                                      className: "form-group"
                                    }, React.createElement("input", {
                                          className: "form-control form-control-lg",
                                          placeholder: "Password",
                                          type: "password"
                                        })), React.createElement("button", {
                                      className: "btn btn-lg btn-primary pull-xs-right"
                                    }, "Sign in")))))));
}

var make = Login;

exports.str = str;
exports.make = make;
/* react Not a pure module */
