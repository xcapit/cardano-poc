use cardano/transaction.{OutputReference, Transaction}

pub type Redeemer {
  SuccessRedeemer
  AnotherSuccessCase
  FailRedeemer
}

validator check_redeemer {
  spend(
    _datum: Option<Data>,
    r: Redeemer,
    _utxo: OutputReference,
    _self: Transaction,
  ) {
    when r is {
      SuccessRedeemer -> True
      AnotherSuccessCase -> True
      _ -> False
    }
  }

  else(_) {
    fail
  }
}

pub type DatumDatum {
  Datum1 { secret: ByteArray }
  Datum2
}

pub type RedeemerDatum {
  RedeemerWithMessage { message: ByteArray }
}

validator check_datum {
  spend(
    d: Option<DatumDatum>,
    r: RedeemerDatum,
    _utxo: OutputReference,
    _self: Transaction,
  ) {
    let RedeemerWithMessage { message } = r
    when d is {
      Some(Datum1 { secret }) -> message == secret
      _ -> False
    }
  }

  else(_) {
    fail
  }
}

validator check_only_input_only_output {
  spend(
    _datum: Option<Data>,
    _redeemer: Data,
    _utxo: OutputReference,
    tx: Transaction,
  ) {
    let Transaction { inputs, outputs, .. } = tx
    when (inputs, outputs) is {
      ([_], [_]) -> True
      _ ->
    }
  }

  else(_) {
    fail
  }
}
