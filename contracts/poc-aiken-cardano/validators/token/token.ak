use aiken/collection/dict
use aiken/collection/list
use cardano/assets.{PolicyId}
use cardano/transaction.{OutputReference, Transaction}

const token_name = "Xcapit"

validator mint_faucet {
  mint(_redeemer: Data, policy_id: PolicyId, tx: Transaction) {
    let Transaction { mint, .. } = tx

    // REMEMBER: si se usa expect, y no cumple con la condicion crashea
    // expect [Pair(asset_name, amount)] =
    //   mint
    //     |> assets.tokens(policy_id)
    //     |> dict.to_pairs()
    let tokens =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()

    when tokens is {
      [Pair(asset_name, amount)] -> amount > 0 && asset_name == token_name
      _ -> False
    }
  }

  else(_) {
    fail
  }
}

const utxo_ref = OutputReference { transaction_id: 0, output_index: 0 }

validator mint_one_shot {
  mint(_redeemer: Data, policy_id: PolicyId, tx: Transaction) {
    let Transaction { inputs, mint, .. } = tx
    expect list.any(inputs, fn(input) { input.output_reference == utxo_ref })

    // REMEMBER: si se usa expect, y no cumple con la condicion crashea
    // expect [Pair(asset_name, amount)] =
    //   mint
    //     |> assets.tokens(policy_id)
    //     |> dict.to_pairs()
    let tokens =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()

    when tokens is {
      [Pair(asset_name, amount)] -> amount > 0 && asset_name == token_name
      _ -> False
    }
  }

  else(_) {
    fail
  }
}
