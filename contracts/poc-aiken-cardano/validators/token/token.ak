// use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

const TOKEN_NAME = "Xcapit"
pub type Action {
  CheckMint
}


validator mint_faucet {

  mint(rdmr: Action, policy_id: PolicyId, tx: Transaction) {
    let Transaction { mint, .. } = transaction
    expect [Pair(asset_name, amount)] =
      mint
        |> assets.tokens(policy_id)
        |> dict.to_pairs()
    when rdmr is {
      CheckMint -> {
        amount > 0 && asset_name == TOKEN_NAME
      }
    }
  }

  else(_) {
    fail
  }
}
