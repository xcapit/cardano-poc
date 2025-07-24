use mocktail.{complete, mint, mocktail_tx}
use mocktail/virgin_key_hash.{mock_policy_id}
use token/token

fn mock_mint() {
  mocktail_tx()
    |> mint(True, 1, mock_policy_id(0), #"cffe")
    |> complete()
}

test mint_xcapit() {
  token.mint_faucet.mint(Void, mock_mint())
}
