use aiken/collection/dict
use aiken/collection/list
use cardano/address.{Script}
use cardano/assets.{PolicyId}
use cardano/transaction.{OutputReference, Transaction}

pub type Action {
  CheckMint
  CheckBurn
}

validator gift_card(token_name: ByteArray, utxo_ref: OutputReference) {
  spend(_d, _r, own_ref: OutputReference, transaction: Transaction) {
    let Transaction { inputs, mint, .. } = transaction
    expect Some(own_input) =
      list.find(inputs, fn(input) { input.output_reference == own_ref })
    expect Script(policy_id) = own_input.output.address.payment_credential
    expect [Pair(asset_name, amount)] =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    amount == -1 && asset_name == token_name
  }

  mint(rdmr: Action, policy_id: PolicyId, transaction: Transaction) {
    let Transaction { inputs, mint, .. } = transaction
    expect [Pair(asset_name, amount)] =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    when rdmr is {
      CheckMint -> {
        expect
          list.any(inputs, fn(input) { input.output_reference == utxo_ref })
        amount == 1 && asset_name == token_name
      }
      CheckBurn -> amount == -1 && asset_name == token_name
    }
  }

  else(_) {
    fail
  }
}

type TestCase {
  action: Action,
  token_name: ByteArray,
  policy_id: PolicyId,
  mint_amount: Int,
  has_utxo_ref_input: Bool,
  has_own_ref_input: Bool,
}

fn get_test_tx(test_case: TestCase, own_ref: OutputReference, utxo_ref: OutputReference) -> Transaction {
  let TestCase {
    action,
    token_name,
    policy_id,
    mint_amount,
    has_utxo_ref_input,
    has_own_ref_input
  } = test_case

  let asset = assets.from_pair(policy_id, token_name, mint_amount)
  let mint = assets.from_token_list([asset])

  let own_input = if has_own_ref_input {
    Some(mock_input(own_ref, script_address(policy_id)))
  } else {
    None
  }

  let utxo_input = if has_utxo_ref_input {
    Some(mock_input(utxo_ref, some_address))
  } else {
    None
  }

  let inputs =
    list.filter_map([own_input, utxo_input], fn(i) { i })

  Transaction {
    inputs,
    mint,
    ..mocktail_tx()
  }
}
test check_mint_passes {
  let token_name = #68656c6c6f  // "hello"
  let policy_id = mock_policy_id()
  let own_ref = mock_output_ref(0)
  let utxo_ref = mock_output_ref(1)

  let tx = get_test_tx(
    TestCase {
      action: CheckMint,
      token_name,
      policy_id,
      mint_amount: 1,
      has_utxo_ref_input: True,
      has_own_ref_input: False  // not needed in `mint`
    },
    own_ref,
    utxo_ref
  )

  gift_card(token_name, utxo_ref).mint(CheckMint, policy_id, tx)
}
