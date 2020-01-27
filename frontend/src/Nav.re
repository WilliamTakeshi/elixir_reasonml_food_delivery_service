[@react.component]
let make = (~loggedIn: bool) => {
  <nav>
    <div className="nav-wrapper cyan lighten-1">
      <Link href="/" className="brand-logo">
        {React.string("Food Delivery")}
      </Link>
      <ul id="nav-mobile" className="right hide-on-med-and-down">
        {if (!loggedIn) {
           <li> <Link href="/login"> {React.string("Login")} </Link> </li>;
         } else {
           <li> <Link href="/logout"> {React.string("Logout")} </Link> </li>;
         }}
        <li>
          <Link href="/restaurants"> {React.string("Restaurants")} </Link>
        </li>
        <li> <Link href="/orders"> {React.string("Orders")} </Link> </li>
      </ul>
    </div>
  </nav>;
};