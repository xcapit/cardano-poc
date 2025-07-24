use token/token

fn mocktail_mint() {
  mocktail_tx()
    |> mint(True, 1, mock_policy_id(0), #"cffe")
    |> complete()
}

test mint_xcapit() {
  let tx = token.mint_faucet.mint()
}
