use mocktail.{complete, mint, mocktail_tx}
use mocktail/virgin_key_hash.{mock_policy_id}
use token/token

type TestCase {
  is_one: Bool,
  is_one_more: Bool,
  is_one_zero: Bool,
}

fn mock_mint(test_case: TestCase) {
  let TestCase { is_one, is_one_more, is_one_zero } = test_case
  mocktail_tx()
    |> mint(is_one, 1, mock_policy_id(0), "Xcapit")
    |> mint(is_one_zero, 0, mock_policy_id(0), "Xcapit")
    |> mint(is_one_more, 1, mock_policy_id(0), "JD")
    |> complete()
}

test mint_xcapit() {
  let test_case =
    TestCase { is_one: True, is_one_more: False, is_one_zero: False }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint(test_case))
}

test mint_jd_fail() fail {
  let test_case =
    TestCase { is_one: False, is_one_more: True, is_one_zero: False }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint(test_case))
}

test mint_jd_xcapit_fail() fail {
  let test_case =
    TestCase { is_one: True, is_one_more: True, is_one_zero: False }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint(test_case))
}

test mint_zero_xcapit_fail() fail {
  let test_case =
    TestCase { is_one: False, is_one_more: False, is_one_zero: True }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint(test_case))
}
