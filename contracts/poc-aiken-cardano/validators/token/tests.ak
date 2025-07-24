use mocktail.{complete, mint, mocktail_tx}
use mocktail/virgin_key_hash.{mock_policy_id}
use token/token

type TestCase {
  is_one: Bool,
  is_one_more: Bool,
}

fn mock_mint(test_case: TestCase) {
  let TestCase { is_one, is_one_more } = test_case
  mocktail_tx()
    |> mint(is_one, 1, mock_policy_id(0), "Xcapit")
    |> mint(is_one_negative, 1, mock_policy_id(0), "JD")
    |> mint(is_one_more, 1, mock_policy_id(0), "JD")
    |> complete()
}

test mint_xcapit() {
  let test_case = TestCase { is_one: True, is_one_more: False }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint(test_case))
}

test mint_xcapit_fail() {
  let test_case = TestCase { is_one: True, is_one_more: True }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint(test_case)) == False
}
