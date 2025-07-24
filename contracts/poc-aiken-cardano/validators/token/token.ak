// use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

const TOKEN_NAME = "Xcapit"
pub type Action {
  CheckMint
}


validator mint_faucet {

  mint(rdmr: Action, policy_id: PolicyId, tx: Transaction) {


  }

  else(_) {
    fail
  }
}
