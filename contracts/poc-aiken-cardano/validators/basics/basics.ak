use cardano/transaction.{OutputReference, Transaction}

pub type Redeemer {
    SuccessRedeemer,

}

validator template {
  spend(
    _datum: Option<Data>,
    _redeemer: Data,
    _utxo: OutputReference,
    _self: Transaction,
  ) {
    todo @"spend logic goes here"
  }

  else(_) {
    fail
  }
}
