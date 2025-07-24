// use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

const TOKEN_NAME = "Xcapit"


validator one_shot_mint {

  else(_) {
    fail
  }
}
