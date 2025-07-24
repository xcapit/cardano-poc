// use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

const TOKEN_NAME = "Xcapit"
pub type Action {
  CheckMint
}


validator mint_faucet {

  mint(rdmr: Data, _policy_id: PolicyId, _self: Transaction) {


  }

  else(_) {
    fail
  }
}
