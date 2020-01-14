'use strict';

var Css = require("bs-css/src/Css.js");
var React = require("react");
var Link$ReasonReactExamples = require("./link.bs.js");

var container = Css.style(/* :: */[
      Css.margin2(Css.px(30), Css.auto),
      /* :: */[
        Css.display(Css.flexBox),
        /* :: */[
          Css.alignItems(Css.center),
          /* :: */[
            Css.flexDirection(Css.column),
            /* [] */0
          ]
        ]
      ]
    ]);

var image = Css.style(/* :: */[
      Css.marginTop(Css.px(60)),
      /* [] */0
    ]);

var text = Css.style(/* :: */[
      Css.marginTop(Css.px(40)),
      /* [] */0
    ]);

var Styles = {
  container: container,
  image: image,
  text: text
};

function NotFound(Props) {
  return React.createElement("div", {
              className: container
            }, React.createElement("div", {
                  className: image
                }, React.createElement("p", undefined, "Add 404 Image"), React.createElement("img", {
                      alt: "Page not found",
                      src: "/src/notfound404.png"
                    })), React.createElement("div", {
                  className: text
                }, React.createElement("span", undefined, "The page you're looking for can't be found. Go home by "), React.createElement(Link$ReasonReactExamples.make, {
                      href: "/",
                      children: "clicking here!"
                    })));
}

var make = NotFound;

exports.Styles = Styles;
exports.make = make;
/* container Not a pure module */
