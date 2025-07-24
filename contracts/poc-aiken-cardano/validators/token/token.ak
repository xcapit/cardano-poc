use aiken/collection/dict
use cardano/assets.{PolicyId}
use cardano/transaction.{Transaction}

const token_name = "Xcapit"

validator mint_faucet {
  mint(_redeemer: Data, policy_id: PolicyId, tx: Transaction) {
    let Transaction { mint, .. } = tx
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
