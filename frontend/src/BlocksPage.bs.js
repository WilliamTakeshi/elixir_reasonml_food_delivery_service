'use strict';

var Block = require("bs-platform/lib/js/block.js");
var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var Belt_Array = require("bs-platform/lib/js/belt_Array.js");
var Json_encode = require("@glennsl/bs-json/src/Json_encode.bs.js");
var Utils$ReasonReactExamples = require("./Utils.bs.js");
var BlockData$ReasonReactExamples = require("./BlockData.bs.js");

var initialState_blocks = /* array */[];

var initialState = {
  blocks: initialState_blocks,
  email: "",
  loading: false
};

function reducer(state, action) {
  if (typeof action === "number") {
    return {
            blocks: state.blocks,
            email: state.email,
            loading: true
          };
  } else if (action.tag) {
    return {
            blocks: state.blocks,
            email: action[0],
            loading: state.loading
          };
  } else {
    return {
            blocks: action[0],
            email: state.email,
            loading: false
          };
  }
}

function makeLine(block, _restaurantId, handleUnblock) {
  return React.createElement("tr", {
              key: String(block.id)
            }, React.createElement("td", undefined, block.user.email), React.createElement("td", undefined, React.createElement("button", {
                      className: "btn btn-lg btn-primary pull-xs-right",
                      onClick: (function (_evt) {
                          return Curry._1(handleUnblock, block.id);
                        })
                    }, "Unblock")));
}

function BlocksPage(Props) {
  var restaurantId = Props.restaurantId;
  var match = React.useReducer(reducer, initialState);
  var dispatch = match[1];
  var state = match[0];
  React.useEffect((function () {
          BlockData$ReasonReactExamples.fetchBlocks(restaurantId, (function (payload) {
                  return Curry._1(dispatch, /* Loaded */Block.__(0, [payload]));
                }));
          return ;
        }), ([]));
  var handleUnblock = function (block_id) {
    BlockData$ReasonReactExamples.unblockUser(restaurantId, block_id);
    return Curry._1(dispatch, /* Loaded */Block.__(0, [state.blocks.filter((function (b) {
                          return block_id !== b.id;
                        }))]));
  };
  return React.createElement("div", {
              className: "container"
            }, React.createElement("div", {
                  className: "row"
                }), React.createElement("div", {
                  className: "input-field col s12"
                }, React.createElement("input", {
                      className: "validate",
                      id: "email",
                      type: "text",
                      value: state.email,
                      onChange: (function (evt) {
                          return Curry._1(dispatch, /* UpdateEmail */Block.__(1, [Utils$ReasonReactExamples.valueFromEvent(evt)]));
                        })
                    }), React.createElement("label", {
                      htmlFor: "email"
                    }, "E-mail"), React.createElement("button", {
                      className: "btn btn-lg btn-primary pull-xs-right",
                      onClick: (function (_evt) {
                          var value = Json_encode.object_(/* :: */[
                                /* tuple */[
                                  "email",
                                  state.email
                                ],
                                /* [] */0
                              ]);
                          BlockData$ReasonReactExamples.blockUser(restaurantId, value);
                          setTimeout((function (param) {
                                  return BlockData$ReasonReactExamples.fetchBlocks(restaurantId, (function (payload) {
                                                return Curry._1(dispatch, /* Loaded */Block.__(0, [payload]));
                                              }));
                                }), 500);
                          return Curry._1(dispatch, /* UpdateEmail */Block.__(1, [""]));
                        })
                    }, "Block")), React.createElement("table", {
                  className: "highlight"
                }, React.createElement("thead", undefined, React.createElement("tr", undefined, React.createElement("th", {
                              width: "70%"
                            }, "Email"), React.createElement("th", {
                              width: "30%"
                            }, "Unblock"))), React.createElement("tbody", undefined, Belt_Array.map(state.blocks, (function (block) {
                            return makeLine(block, restaurantId, handleUnblock);
                          })))));
}

var make = BlocksPage;

exports.initialState = initialState;
exports.reducer = reducer;
exports.makeLine = makeLine;
exports.make = make;
/* react Not a pure module */
