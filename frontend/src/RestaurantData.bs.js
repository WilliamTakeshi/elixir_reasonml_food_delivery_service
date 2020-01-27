'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var Fetch = require("bs-fetch/src/Fetch.js");
var Caml_option = require("bs-platform/lib/js/caml_option.js");
var Json_decode = require("@glennsl/bs-json/src/Json_decode.bs.js");
var AuthData$ReasonReactExamples = require("./AuthData.bs.js");

var apiBaseUrl = "http://localhost:4000";

function meal(json) {
  return {
          active: Json_decode.field("active", Json_decode.bool, json),
          id: Json_decode.field("id", Json_decode.$$int, json),
          description: Json_decode.field("description", Json_decode.string, json),
          imgUrl: Json_decode.field("img_url", Json_decode.string, json),
          name: Json_decode.field("name", Json_decode.string, json),
          price: Json_decode.field("price", Json_decode.$$int, json),
          restaurantId: Json_decode.field("restaurant_id", Json_decode.$$int, json)
        };
}

function restaurant(json) {
  return {
          description: Json_decode.field("description", Json_decode.string, json),
          id: Json_decode.field("id", Json_decode.$$int, json),
          imgUrl: Json_decode.field("img_url", Json_decode.string, json),
          name: Json_decode.field("name", Json_decode.string, json)
        };
}

function restaurantWithMeal(json) {
  return {
          description: Json_decode.field("description", Json_decode.string, json),
          id: Json_decode.field("id", Json_decode.$$int, json),
          imgUrl: Json_decode.field("img_url", Json_decode.string, json),
          name: Json_decode.field("name", Json_decode.string, json),
          meals: Json_decode.field("meals", (function (param) {
                  return Json_decode.array(meal, param);
                }), json)
        };
}

function restaurants(json) {
  return Json_decode.array(restaurant, json);
}

var Decode = {
  meal: meal,
  restaurant: restaurant,
  restaurantWithMeal: restaurantWithMeal,
  restaurants: restaurants
};

function fetchRestaurants(callback) {
  fetch("" + (String(apiBaseUrl) + "/api/v1/restaurants"), Fetch.RequestInit.make(/* Get */0, {
                  Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt")
                }, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          var restaurants$1 = Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], restaurants)(json);
          Curry._1(callback, restaurants$1);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function fetchRestaurantWithMeal(id, callback) {
  var strId = String(id);
  fetch("" + (String(apiBaseUrl) + ("/api/v1/restaurants/" + (String(strId) + ""))), Fetch.RequestInit.make(/* Get */0, {
                  Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt")
                }, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          var restaurant = Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], restaurantWithMeal)(json);
          Curry._1(callback, restaurant);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function updateRestaurant(id, body) {
  var strId = String(id);
  fetch("" + (String(apiBaseUrl) + ("/api/v1/restaurants/" + (String(strId) + ""))), Fetch.RequestInit.make(/* Put */3, {
                "Content-Type": "application/json",
                Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt")
              }, Caml_option.some(JSON.stringify(body)), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
          return prim.json();
        }));
  return /* () */0;
}

function fetchMeal(mealId, restaurantId, callback) {
  var strMealId = String(mealId);
  var strRestaurantId = String(restaurantId);
  fetch("" + (String(apiBaseUrl) + ("/api/v1/restaurants/" + (String(strRestaurantId) + ("/meals/" + (String(strMealId) + ""))))), Fetch.RequestInit.make(/* Get */0, {
                  Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt")
                }, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
            return prim.json();
          })).then((function (json) {
          var meal$1 = Json_decode.at(/* :: */[
                  "data",
                  /* [] */0
                ], meal)(json);
          Curry._1(callback, meal$1);
          return Promise.resolve(/* () */0);
        }));
  return /* () */0;
}

function updateMeal(mealId, restaurantId, body) {
  var strMealId = String(mealId);
  var strRestaurantId = String(restaurantId);
  fetch("" + (String(apiBaseUrl) + ("/api/v1/restaurants/" + (String(strRestaurantId) + ("/meals/" + (String(strMealId) + ""))))), Fetch.RequestInit.make(/* Put */3, {
                "Content-Type": "application/json",
                Authorization: AuthData$ReasonReactExamples.getFromStorage("jwt")
              }, Caml_option.some(JSON.stringify(body)), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined)(/* () */0)).then((function (prim) {
          return prim.json();
        }));
  return /* () */0;
}

exports.apiBaseUrl = apiBaseUrl;
exports.Decode = Decode;
exports.fetchRestaurants = fetchRestaurants;
exports.fetchRestaurantWithMeal = fetchRestaurantWithMeal;
exports.updateRestaurant = updateRestaurant;
exports.fetchMeal = fetchMeal;
exports.updateMeal = updateMeal;
/* AuthData-ReasonReactExamples Not a pure module */
