use cardano/assets.{PolicyId}
use cardano/transaction.{OutputReference, Transaction} as tx

validator gift_card(token_name: ByteArray, utxo_ref: OutputReference) {
  spend(_d, _r, own_ref: OutputReference, transaction: Transaction) {
    todo @"redeem"
  }

  mint(_rdmr: Data, policy_id: PolicyId, transaction: Transaction) {
    todo @"mint and burn"
  }

  else(_) {
    fail
  }
}
