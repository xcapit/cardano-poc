use aiken/collection/dict
use aiken/collection/list
use cardano/assets.{PolicyId}
use cardano/transaction.{OutputReference, Transaction}

pub type Action {
  CheckMint
  CheckBurn
}

validator gift_card(token_name: ByteArray, utxo_ref: OutputReference) {
  // spend(_d, _r, own_ref: OutputReference, transaction: Transaction) {
  //   let Transaction { inputs, mint, .. } = transaction
  // }

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
  is_pair_token_amount: Bool,
}

fn get_test_tx(test_case: TestCase) {
  let TestCase { is_pair_token_amount } = test_case
  mocktail_tx()
    |> required_signer_hash(is_owner_signed, mock_pub_key_hash(1))
    |> required_signer_hash(is_beneficiary_signed, mock_pub_key_hash(2))
    |> invalid_before(is_lock_time_passed, 10001)
    |> complete()
}
