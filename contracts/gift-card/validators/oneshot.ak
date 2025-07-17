use aiken/collection/dict
use cardano/assets.{PolicyId}
use cardano/transaction.{OutputReference, Transaction} as tx
use mocktail/virgin_key_hash.{mock_policy_id}

type Action {
  CheckMint
  CheckBurn
}

validator gift_card(token_name: ByteArray, utxo_ref: OutputReference) {
  spend(_d, _r, own_ref: OutputReference, transaction: Transaction) {
    todo @"redeem"
  }

  mint(rdmr: Action, policy_id: PolicyId, transaction: Transaction) {
    let Transaction { inputs, mint, .. } = transaction
    expect [Pair(asset_name, amount)] =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    when rdmr is {
      CheckMint -> todo @"mint"
      CheckBurn -> todo @"burn"
    }
  }

  else(_) {
    fail
  }
}

test check_mint() {
  let policy_id = mocktail.mock_policy_id(1)
  let asset_name = b
  "GIFT"
  let amount = 1
  let mint_dict =
    dict.new()
      |> dict.insert((policy_id, asset_name), amount)

  let tx =
    mocktail.mocktail_tx()
      |> mocktail.with_mint(mint_dict)
      |> mocktail.complete()

  // Ejecutamos el validador con CheckMint
  gift_card.mint(CheckMint, policy_id, tx)
}
