'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var Fetch = require("bs-fetch/src/Fetch.js");
var Caml_option = require("bs-platform/lib/js/caml_option.js");
var Json_decode = require("@glennsl/bs-json/src/Json_decode.bs.js");
var ReasonReactRouter = require("reason-react/src/ReasonReactRouter.js");

var apiBaseUrl = "http://localhost:4000";

function saveToStorage(key_, value) {
  localStorage.setItem(key_, value);
  return /* () */0;
}

function getFromStorage(key_) {
  return Caml_option.null_to_opt(localStorage.getItem(key_));
}

function removeFromStorage(key_) {
  localStorage.removeItem(key_);
  return /* () */0;
}

function isUserLoggedIn(param) {
  var match = localStorage.getItem("jwt");
  return match !== null;
}

function token(json) {
  return {
          token: Json_decode.field("token", Json_decode.string, json),
          renew_token: Json_decode.field("renew_token", Json_decode.string, json)
        };
}

function user(json) {
  return {
          id: Json_decode.field("id", Json_decode.$$int, json),
          email: Json_decode.field("email", Json_decode.string, json),
          role: Json_decode.field("role", Json_decode.string, json)
        };
}

var Decode = {
  token: token,
  user: user
};

function me(param) {
  fetch("" + (String(apiBaseUrl) + "/api/v1/me"), Fetch.RequestInit.make(/* Get */0, {
                  Authorization: Caml_option.null_to_opt(localStorage.getItem("jwt")),
                  "Content-Type": "application/json"
                }, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          var user$1 = Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], user)(json);
          saveToStorage("user_role", user$1.role);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function login(body) {
  fetch("" + (String(apiBaseUrl) + "/api/v1/session"), Fetch.RequestInit.make(/* Post */2, {
                  "Content-Type": "application/json"
                }, Caml_option.some(JSON.stringify(body)), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          var token$1 = Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], token)(json);
          saveToStorage("jwt", token$1.token);
          saveToStorage("renew_token", token$1.renew_token);
          me(/* () */0);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function logout(param) {
  fetch("" + (String(apiBaseUrl) + "/api/v1/session"), Fetch.RequestInit.make(/* Delete */4, {
                  "Content-Type": "application/json"
                }, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (_json) {
          localStorage.removeItem("jwt");
          localStorage.removeItem("renew_token");
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function registration(body) {
  fetch("" + (String(apiBaseUrl) + "/api/v1/registration"), Fetch.RequestInit.make(/* Post */2, {
                  "Content-Type": "application/json"
                }, Caml_option.some(JSON.stringify(body)), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], token)(json);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function confirmEmail(token, callback) {
  fetch("" + (String(apiBaseUrl) + ("/api/v1/confirm_email/" + (String(token) + "")))).then((function (prim) {
            return prim.json();
          })).then((function (_json) {
          Curry._1(callback, (function (param) {
                  return "Email confirmed with success";
                }));
          setTimeout((function (param) {
                  return ReasonReactRouter.push("/");
                }), 1500);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

exports.apiBaseUrl = apiBaseUrl;
exports.saveToStorage = saveToStorage;
exports.getFromStorage = getFromStorage;
exports.removeFromStorage = removeFromStorage;
exports.isUserLoggedIn = isUserLoggedIn;
exports.Decode = Decode;
exports.me = me;
exports.login = login;
exports.logout = logout;
exports.registration = registration;
exports.confirmEmail = confirmEmail;
/* ReasonReactRouter Not a pure module */
