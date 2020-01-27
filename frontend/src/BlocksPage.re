open Utils;
open Belt;

type state = {
  blocks: BlockData.blocks,
  email: string,
  loading: bool,
};

type action =
  | Loaded(BlockData.blocks)
  | Loading
  | UpdateEmail(string);

let initialState = {blocks: [||], email: "", loading: false};

let reducer = (state, action) =>
  switch (action) {
  | Loading => {...state, loading: true}
  | Loaded(blocks) => {...state, blocks, loading: false}
  | UpdateEmail(email) => {...state, email}
  };

let makeLine = (block: BlockData.block, restaurantId, handleUnblock) => {
  <tr key={string_of_int(block.id)}>
    <td> {React.string(block.user.email)} </td>
    <td>
      <button
        onClick={_evt => handleUnblock(block.id)}
        className="btn btn-lg btn-primary pull-xs-right">
        {React.string("Unblock")}
      </button>
    </td>
  </tr>;
};

[@react.component]
let make = (~restaurantId) => {
  let (state, dispatch) = React.useReducer(reducer, initialState);

  React.useEffect0(() => {
    BlockData.fetchBlocks(restaurantId, payload => dispatch(Loaded(payload)))
    |> ignore;
    None;
  });

  let handleUnblock = (block_id: int) => {
    BlockData.unblockUser(restaurantId, block_id);
    dispatch(Loaded(state.blocks->filter(b => block_id !== b.id)));
  };

  let handleSubmit = value => {
    BlockData.blockUser(restaurantId, value);
    Js.Global.setTimeout(
      _ =>
        BlockData.fetchBlocks(restaurantId, payload =>
          dispatch(Loaded(payload))
        ),
      500,
    )
    |> ignore;
    dispatch(UpdateEmail(""));
  };

  <div className="container">
    <div className="row" />
    <div className="input-field col s12">
      <input
        id="email"
        type_="text"
        className="validate"
        value={state.email}
        onChange={evt => valueFromEvent(evt)->UpdateEmail |> dispatch}
      />
      <label htmlFor="email"> {React.string("E-mail")} </label>
      <button
        onClick={_evt =>
          handleSubmit(
            Json.Encode.(object_([("email", string(state.email))])),
          )
        }
        className="btn btn-lg btn-primary pull-xs-right">
        {React.string("Block")}
      </button>
    </div>
    <table className="highlight">
      <thead>
        <tr>
          <th> {React.string("Email")} </th>
          <th> {React.string("Unblock")} </th>
        </tr>
      </thead>
      <tbody>
        {state.blocks
         ->(Array.map(block => makeLine(block, restaurantId, handleUnblock)))
         ->React.array}
      </tbody>
    </table>
  </div>;
};