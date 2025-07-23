use aiken/crypto.{VerificationKeyHash}

pub type Datum {
  TokenState { total_supply: Int, owner: VerificationKeyHash }
}

const token_name = "Xcapit"

const token_symbol = "Xc"

validator token {
  spend(
    _datum: Option<Data>,
    _redeemer: Data,
    _utxo: OutputReference,
    _self: Transaction,
  ) {
    todo
  }

  else(_) {
    fail
  }
}
