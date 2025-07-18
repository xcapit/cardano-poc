use aiken/collection/dict
use aiken/collection/list
use cardano/address.{Script}
use cardano/assets.{PolicyId}
use cardano/transaction.{OutputReference, Transaction}
use mocktail/virgin_key_hash.{mock_pub_key_hash}
use mocktail/virgin_output_reference.{mock_utxo_ref}

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

test mint_check_mint_valid_token() {
  let token_name = ""
  let policy_id = ""
  let utxo_ref = mock_utxo_ref(0, 0)

  let mint_map =
    dict.insert(token_name, 2)
      |> {
          let tx =
            transaction.Transaction {
              ..transaction.placeholder,
              inputs: [
                transaction.input(
                  mock_utxo_ref(0, 0),
                  transaction.output(transaction.mock_address, value.zero),
                ),
              ],
              mint: dict.insert(policy_id, mint_map),
              extra_signatories: [mock_pub_key_hash(1)],
            }
        }

  gift_card(token_name, utxo_ref).mint(CheckMint, policy_id, tx)
}
