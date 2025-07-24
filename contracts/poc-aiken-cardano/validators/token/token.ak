// use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

const TOKEN_NAME = "Xcapit"


validator mint_faucet {

  else(_) {
    fail
  }
}
