use aiken/collection/dict
use cardano/assets.{PolicyId}
use cardano/transaction.{Transaction}

const token_name = "Xcapit"

pub type Action {
  CheckMint
  CheckBurn
}

validator mint_faucet {
  mint(rdmr: Action, policy_id: PolicyId, tx: Transaction) {
    let Transaction { mint, .. } = tx
    expect [Pair(asset_name, amount)] =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    when rdmr is {
      CheckMint -> amount > 0 && asset_name == token_name
      CheckBurn -> False
    }
  }

  else(_) {
    fail
  }
}
