'use strict';

var Block = require("bs-platform/lib/js/block.js");
var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Json_encode = require("@glennsl/bs-json/src/Json_encode.bs.js");
var Link$ReasonReactExamples = require("./link.bs.js");
var Utils$ReasonReactExamples = require("./Utils.bs.js");
var AuthData$ReasonReactExamples = require("./AuthData.bs.js");

function str(prim) {
  return prim;
}

var initialState = {
  email: "",
  password: "",
  confirmPassword: "",
  hasValidationError: false,
  errorList: /* [] */0
};

function reducer(state, action) {
  if (typeof action === "number") {
    return initialState;
  } else {
    switch (action.tag | 0) {
      case /* EmailUpdate */0 :
          return {
                  email: action[0],
                  password: state.password,
                  confirmPassword: state.confirmPassword,
                  hasValidationError: state.hasValidationError,
                  errorList: state.errorList
                };
      case /* PasswordUpdate */1 :
          return {
                  email: state.email,
                  password: action[0],
                  confirmPassword: state.confirmPassword,
                  hasValidationError: state.hasValidationError,
                  errorList: state.errorList
                };
      case /* ConfirmPasswordUpdate */2 :
          return {
                  email: state.email,
                  password: state.password,
                  confirmPassword: action[0],
                  hasValidationError: state.hasValidationError,
                  errorList: state.errorList
                };
      
    }
  }
}

function CreateAccount(Props) {
  var match = React.useReducer(reducer, initialState);
  var dispatch = match[1];
  var state = match[0];
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
                            }, "Create an account"), React.createElement(Link$ReasonReactExamples.make, {
                              href: "/",
                              children: "Already have an account"
                            }), React.createElement("input", {
                              className: "form-control form-control-lg",
                              placeholder: "Email",
                              type: "text",
                              value: state.email,
                              onChange: (function (evt) {
                                  return Curry._1(dispatch, /* EmailUpdate */Block.__(0, [Utils$ReasonReactExamples.valueFromEvent(evt)]));
                                })
                            }), React.createElement("input", {
                              className: "form-control form-control-lg",
                              placeholder: "Password",
                              type: "password",
                              value: state.password,
                              onChange: (function (evt) {
                                  return Curry._1(dispatch, /* PasswordUpdate */Block.__(1, [Utils$ReasonReactExamples.valueFromEvent(evt)]));
                                })
                            }), React.createElement("input", {
                              className: "form-control form-control-lg",
                              placeholder: "Confirm Password",
                              type: "password",
                              value: state.confirmPassword,
                              onChange: (function (evt) {
                                  return Curry._1(dispatch, /* ConfirmPasswordUpdate */Block.__(2, [Utils$ReasonReactExamples.valueFromEvent(evt)]));
                                })
                            }), React.createElement("button", {
                              className: "btn btn-lg btn-primary pull-xs-right",
                              onClick: (function (_evt) {
                                  var state$1 = Json_encode.object_(/* :: */[
                                        /* tuple */[
                                          "user",
                                          Json_encode.object_(/* :: */[
                                                /* tuple */[
                                                  "email",
                                                  state.email
                                                ],
                                                /* :: */[
                                                  /* tuple */[
                                                    "password",
                                                    state.password
                                                  ],
                                                  /* :: */[
                                                    /* tuple */[
                                                      "confirm_password",
                                                      state.confirmPassword
                                                    ],
                                                    /* [] */0
                                                  ]
                                                ]
                                              ])
                                        ],
                                        /* [] */0
                                      ]);
                                  AuthData$ReasonReactExamples.registration(state$1);
                                  return Curry._1(dispatch, /* ResetState */0);
                                })
                            }, "Create")))));
}

var make = CreateAccount;

exports.str = str;
exports.initialState = initialState;
exports.reducer = reducer;
exports.make = make;
/* react Not a pure module */
