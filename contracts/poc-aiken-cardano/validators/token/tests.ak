use cardano/assets.{from_lovelace}
use mocktail.{complete, mint, mocktail_tx, tx_in}
use mocktail/virgin_address.{mock_pub_key_address}
use mocktail/virgin_key_hash.{mock_policy_id}
use mocktail/virgin_output_reference.{mock_tx_hash}
use token/token

type TestCase {
  is_one: Bool,
  is_one_more: Bool,
  is_one_zero: Bool,
}

fn mock_mint_faucet(test_case: TestCase) {
  let TestCase { is_one, is_one_more, is_one_zero } = test_case
  mocktail_tx()
    |> mint(is_one, 1, mock_policy_id(0), "Xcapit")
    |> mint(is_one_zero, 0, mock_policy_id(0), "Xcapit")
    |> mint(is_one_more, 1, mock_policy_id(0), "JD")
    |> complete()
}

fn mock_mint_one_shot(test_case: TestCase) {
  let TestCase { is_one, is_one_more, is_one_zero } = test_case
  mocktail_tx()
    |> tx_in(
        True,
        mock_tx_hash(0),
        0,
        from_lovelace(10_000_000),
        mock_pub_key_address(0, None),
      )
    |> mint(is_one, 1, mock_policy_id(0), "Xcapit")
    |> mint(is_one_zero, 0, mock_policy_id(0), "Xcapit")
    |> mint(is_one_more, 1, mock_policy_id(0), "JD")
    |> complete()
}

test mint_xcapit() {
  let test_case =
    TestCase { is_one: True, is_one_more: False, is_one_zero: False }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint_faucet(test_case))
}

test mint_jd_fail() fail {
  let test_case =
    TestCase { is_one: False, is_one_more: True, is_one_zero: False }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint_faucet(test_case))
}

test mint_jd_xcapit_fail() fail {
  let test_case =
    TestCase { is_one: True, is_one_more: True, is_one_zero: False }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint_faucet(test_case))
}

test mint_zero_xcapit_fail() fail {
  let test_case =
    TestCase { is_one: False, is_one_more: False, is_one_zero: True }
  token.mint_faucet.mint(Void, mock_policy_id(0), mock_mint_faucet(test_case))
}

test mint_xcapit_one_shot() {
  let test_case =
    TestCase { is_one: True, is_one_more: False, is_one_zero: False }
  token.mint_one_shot.mint(
    Void,
    mock_policy_id(0),
    mock_mint_one_shot(test_case),
  )
}

test mint_jd_one_shot() fail {
  let test_case =
    TestCase { is_one: False, is_one_more: True, is_one_zero: False }
  token.mint_one_shot.mint(
    Void,
    mock_policy_id(0),
    mock_mint_one_shot(test_case),
  )
}

test mint_xcapit_jd_one_shot() fail {
  let test_case =
    TestCase { is_one: False, is_one_more: True, is_one_zero: False }
  token.mint_one_shot.mint(
    Void,
    mock_policy_id(0),
    mock_mint_one_shot(test_case),
  )
}
