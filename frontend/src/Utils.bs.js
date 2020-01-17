'use strict';


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

exports.fromNow = fromNow;
exports.dangerousHtml = dangerousHtml;
exports.distanceFromBottom = distanceFromBottom;
exports.valueFromEvent = valueFromEvent;
/* No side effect */
