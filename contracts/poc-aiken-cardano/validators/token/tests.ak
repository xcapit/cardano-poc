use mocktail.{complete, mint, mocktail_tx}
use mocktail/virgin_key_hash.{mock_policy_id}
use token/token

type TestCase {
  is_one: Bool,
  is_other: Bool,
}

fn mock_mint(test_case: TestCase) {
  let TestCase = test_case
  mocktail_tx()
    |> mint(True, 1, mock_policy_id(0), "Xcapit")
    |> complete()
}

test mint_xcapit() {
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint())
}
