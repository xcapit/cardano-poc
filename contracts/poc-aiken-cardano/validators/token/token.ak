use aiken/crypto.{VerificationKeyHash}

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
