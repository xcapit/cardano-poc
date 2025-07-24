// use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

const TOKEN_NAME = "Xcapit"


validator mint_faucet {

  mint(_redeemer: Data, _policy_id: PolicyId, _self: Transaction) {
  }

  else(_) {
    fail
  }
}
