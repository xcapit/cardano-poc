use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

pub type Datum {
  TokenState { total_supply: Int, owner: VerificationKeyHash }
}

const token_name = "Xcapit"

const token_symbol = "Xc"

validator token {
  else(_) {
    fail
  }
}
