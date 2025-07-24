// use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

const token_name = "Xcapit"

const token_symbol = "Xc"

validator one_shot_mint {
  else(_) {
    fail
  }
}
