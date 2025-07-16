use cardano/assets.{PolicyId}
use cardano/transaction.{OutputReference, Transaction} as tx

type Action {
  CheckMint
  CheckBurn
}

validator gift_card(token_name: ByteArray, utxo_ref: OutputReference) {
  spend(_d, _r, own_ref: OutputReference, transaction: Transaction) {
    todo @"redeem"
  }

  mint(rdmr: Action, policy_id: PolicyId, transaction: Transaction) {
    when rdmr is {
      CheckMint -> todo @"mint"
      CheckBurn -> todo @"burn"
    }
  }

  else(_) {
    fail
  }
}
