# FoodDelivery FrontEnd

The frontend is written in ReasonReact, lets you write simple, fast and quality type safe code with great interop with JavaScript.

## Run

```sh
npm install
npm run server
# in a new tab
npm start
```

Open a new web page to `http://localhost:8000/`. Change any `.re` file in `src` to see the page auto-reload. **You don't need any bundler when you're developing**!

## How to contribute

The best file to start reading the code is `app.re`. There is the ReasonReact Router where we make all pattern matchs to see with route the user will see. The router also checks if the user has permission to see the route.

### Pages

The pages are defined with names `*Page.re`. This is where the rendering and all the calls to the API are started.

### Data

The data are defined with names `*Data.re`. This files define the types of each entity and carry all the logic to make the call to the API.

### Utils

The `Utils.re` are pure functions that can be used by any module. It has some interop with JavaScript (for example the `filter`), or functions defined for this application especifically (for example `distanceFromBottom` to make a infinite scroll (not implemented)).
