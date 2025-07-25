use aiken/collection/dict
use aiken/collection/list
use cardano/assets.{PolicyId}
use cardano/transaction.{OutputReference, Transaction}

const token_name = "Xcapit"

// REMEMBER: si se usa expect, y no cumple con la condicion crashea, por lo que hay q poner los test con el tag fail

validator mint_faucet {
  mint(_redeemer: Data, policy_id: PolicyId, tx: Transaction) {
    let Transaction { mint, .. } = tx
    expect [Pair(asset_name, amount)] =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    amount > 0 && asset_name == token_name
  }

  else(_) {
    fail
  }
}

const utxo_ref =
  OutputReference {
    transaction_id: "CD82A190D3B4EF95A50BD791882959F541E308ADB69B12D022D94A6D9F02BCF0",
    output_index: 0,
  }

validator mint_one_shot {
  mint(_redeemer: Data, policy_id: PolicyId, tx: Transaction) {
    let Transaction { inputs, mint, .. } = tx
    trace @"utxo_ref": utxo_ref
    expect list.any(inputs, fn(input) { input.output_reference == utxo_ref })
    expect [Pair(asset_name, amount)] =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    amount > 0 && asset_name == token_name
  }

  else(_) {
    fail
  }
}
