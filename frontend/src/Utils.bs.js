'use strict';

var AuthData$ReasonReactExamples = require("./AuthData.bs.js");

function fromNow(unixtime) {
  var delta = (Date.now() / 1000 | 0) - unixtime | 0;
  if (delta < 3600) {
    return String(delta / 60 | 0) + " minutes ago";
  } else if (delta < 86400) {
    return String(delta / 3600 | 0) + " hours ago";
  } else {
    return String(delta / 86400 | 0) + " days ago";
  }
}

function dangerousHtml(html) {
  return {
          __html: html
        };
}

function distanceFromBottom(param) {
  var bodyClientHeight = (document.body.clientHeight);
  var windowScrollY = (window.scrollY);
  var windowInnerHeight = (window.innerHeight);
  return bodyClientHeight - (windowScrollY + windowInnerHeight | 0) | 0;
}

function valueFromEvent(evt) {
  return evt.target.value;
}

function toMoneyFormat(value) {
  var dollar = value / 100 | 0;
  var cents = value % 100;
  if (cents < 10) {
    return "US\$ " + (String(dollar) + (".0" + (String(cents) + "")));
  } else {
    return "US\$ " + (String(dollar) + ("." + (String(cents) + "")));
  }
}

function translateStatus(status) {
  switch (status) {
    case "canceled" :
        return "Canceled";
    case "delivered" :
        return "Delivered";
    case "in_route" :
        return "In Route";
    case "not_placed" :
        return "Not Placed";
    case "placed" :
        return "Placed";
    case "processing" :
        return "Processing";
    case "received" :
        return "Received";
    default:
      return "error";
  }
}

function nextStatus(thisStatus) {
  var match = AuthData$ReasonReactExamples.getFromStorage("user_role");
  switch (thisStatus) {
    case "delivered" :
        if (match === "user") {
          return "received";
        } else {
          return "error";
        }
    case "in_route" :
        if (match === "owner") {
          return "delivered";
        } else {
          return "error";
        }
    case "not_placed" :
        if (match === "user") {
          return "placed";
        } else {
          return "error";
        }
    case "placed" :
        if (match !== undefined) {
          switch (match) {
            case "owner" :
                return "processing";
            case "user" :
                return "canceled";
            default:
              return "error";
          }
        } else {
          return "error";
        }
    case "processing" :
        if (match === "owner") {
          return "in_route";
        } else {
          return "error";
        }
    default:
      return "error";
  }
}

exports.fromNow = fromNow;
exports.dangerousHtml = dangerousHtml;
exports.distanceFromBottom = distanceFromBottom;
exports.valueFromEvent = valueFromEvent;
exports.toMoneyFormat = toMoneyFormat;
exports.translateStatus = translateStatus;
exports.nextStatus = nextStatus;
/* AuthData-ReasonReactExamples Not a pure module */
