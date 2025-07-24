// use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}

const TOKEN_NAME = "Xcapit"
pub type Action {
  CheckMint
}


validator mint_faucet {

  mint(rdmr: Action, policy_id: PolicyId, tx: Transaction) {
    when rdmr is {
      CheckMint -> {
        expect
          list.any(inputs, fn(input) { input.output_reference == utxo_ref })
        amount > 0 && asset_name == token_name
      }
    }
  }

  else(_) {
    fail
  }
}
