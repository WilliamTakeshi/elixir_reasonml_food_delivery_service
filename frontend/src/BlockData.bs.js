'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var Fetch = require("bs-fetch/src/Fetch.js");
var Caml_option = require("bs-platform/lib/js/caml_option.js");
var Json_decode = require("@glennsl/bs-json/src/Json_decode.bs.js");
var AuthData$ReasonReactExamples = require("./AuthData.bs.js");

var apiBaseUrl = "http://localhost:4000";

function block(json) {
  return {
          id: Json_decode.field("id", Json_decode.$$int, json),
          restaurant_id: Json_decode.field("restaurant_id", Json_decode.$$int, json),
          user: Json_decode.field("user", AuthData$ReasonReactExamples.Decode.user, json),
          user_id: Json_decode.field("user_id", Json_decode.$$int, json)
        };
}

function blocks(json) {
  return Json_decode.array(block, json);
}

var Decode = {
  block: block,
  blocks: blocks
};

function fetchBlocks(restaurantId, callback) {
  fetch("" + (String(apiBaseUrl) + ("/api/v1/restaurants/" + (String(restaurantId) + "/blocks"))), Fetch.RequestInit.make(/* Get */0, {
                  Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt"),
                  "Content-Type": "application/json"
                }, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          var blocks$1 = Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], blocks)(json);
          Curry._1(callback, blocks$1);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function blockUser(restaurantId, body) {
  fetch("" + (String(apiBaseUrl) + ("/api/v1/restaurants/" + (String(restaurantId) + "/blocks"))), Fetch.RequestInit.make(/* Post */2, {
                Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt"),
                "Content-Type": "application/json"
              }, Caml_option.some(JSON.stringify(body)), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
          return prim.json();
        }));
  return /* () */0;
}

function unblockUser(restaurantId, blockId) {
  fetch("" + (String(apiBaseUrl) + ("/api/v1/restaurants/" + (String(restaurantId) + ("/blocks/" + (String(blockId) + ""))))), Fetch.RequestInit.make(/* Delete */4, {
                Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt"),
                "Content-Type": "application/json"
              }, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
          return prim.json();
        }));
  return /* () */0;
}

exports.apiBaseUrl = apiBaseUrl;
exports.Decode = Decode;
exports.fetchBlocks = fetchBlocks;
exports.blockUser = blockUser;
exports.unblockUser = unblockUser;
/* AuthData-ReasonReactExamples Not a pure module */
