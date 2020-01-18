// let src: string = [%raw "require('src/notfound404.png')"];

module Styles = {
  /* Open the Css module, so we can access the style properties below without prefixing them with Css. */
  open Css;

  let container =
    style([
      margin2(px(30), auto),
      display(flexBox),
      alignItems(center),
      flexDirection(column),
    ]);

  let image = style([marginTop(px(60))]);

  let text = style([marginTop(px(40))]);
};

[@react.component]
let make = () =>
  <div className=Styles.container>
    <div className=Styles.image>
      <img alt="Page not found" src="/src/notfound404.png" />
    </div>
    <div className=Styles.text>
      <span>
        {React.string(
           "The page you're looking for can't be found. Go home by ",
         )}
      </span>
      <Link href="/"> {React.string("clicking here!")} </Link>
    </div>
  </div>;