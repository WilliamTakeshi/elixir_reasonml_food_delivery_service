'use strict';

var Fetch = require("bs-fetch/src/Fetch.js");
var Caml_option = require("bs-platform/lib/js/caml_option.js");
var Json_decode = require("@glennsl/bs-json/src/Json_decode.bs.js");

var apiBaseUrl = "http://localhost:4000";

function loginResponse(json) {
  return {
          token: Json_decode.field("token", Json_decode.string, json),
          renew_token: Json_decode.field("renew_token", Json_decode.string, json)
        };
}

var Decode = {
  loginResponse: loginResponse
};

function postLogin(body) {
  fetch("" + (String(apiBaseUrl) + "/api/v1/session"), Fetch.RequestInit.make(/* Post */2, {
                  "Content-Type": "application/json"
                }, Caml_option.some(JSON.stringify(body)), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          loginResponse(json);
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
          loginResponse(json);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

exports.apiBaseUrl = apiBaseUrl;
exports.Decode = Decode;
exports.postLogin = postLogin;
exports.registration = registration;
/* No side effect */
