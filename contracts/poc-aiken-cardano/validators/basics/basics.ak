use cardano/transaction.{OutputReference, Transaction}

pub type Redeemer {
    SuccessRedeemer,
    AnotherSuccessCase,
    FailRedeemer
}

validator template {
  spend(
    _datum: Option<Data>,
    r: Data,
    _utxo: OutputReference,
    _self: Transaction,
  ) {
    when r is {
        
    }
  }

  else(_) {
    fail
  }
}
