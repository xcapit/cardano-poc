use cardano/transaction.{OutputReference, Transaction}

pub type Redeemer {
    SuccessRedeemer
    AnotherSuccessCase
    FailRedeemer
}

validator basics {
  spend(
    _datum: Option<Data>,
    r: Data,
    _utxo: OutputReference,
    _self: Transaction,
  ) {
    when r is {
        SuccessRedeemer -> True,
        AnotherSuccessCase -> True,
        _ -> False
    }
  }

  else(_) {
    fail
  }
}

