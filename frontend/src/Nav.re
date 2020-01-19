[@react.component]
let make = () => {
  <nav>
    <div className="nav-wrapper cyan lighten-1">
      <Link href="/" className="brand-logo">
        {Utils.str("Food Delivery")}
      </Link>
      <ul id="nav-mobile" className="right hide-on-med-and-down">
        <li>
          <Link href="/restaurants"> {Utils.str("Restaurants")} </Link>
        </li>
        <li> <Link href="/orders"> {Utils.str("Shopping Cart")} </Link> </li>
      </ul>
    </div>
  </nav>;
};