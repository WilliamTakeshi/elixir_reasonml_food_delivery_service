'use strict';

var React = require("react");

function HomePage(Props) {
  return React.createElement("div", {
              className: "container"
            }, React.createElement("div", {
                  className: "center"
                }, React.createElement("img", {
                      alt: "girl sitting",
                      src: "/img/sitting-2.svg"
                    }), React.createElement("h5", undefined, "Ask food anytime anywhere")));
}

var make = HomePage;

exports.make = make;
/* react Not a pure module */
