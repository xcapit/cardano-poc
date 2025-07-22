use basics/basics.{
  AnotherSuccessCase, Datum1, Datum2, FailRedeemer, RedeemerWithMessage,
  SuccessRedeemer,
}
use cardano/transaction.{placeholder}
use mocktail/virgin_output_reference.{mock_utxo_ref}

test check_redeemer_sucess() {
  basics.check_redeemer.spend(
    None,
    SuccessRedeemer,
    mock_utxo_ref(0, 0),
    placeholder,
  )
}

test check_redeemer_success_2() {
  basics.check_redeemer.spend(
    None,
    AnotherSuccessCase,
    mock_utxo_ref(0, 0),
    placeholder,
  )
}

test check_redeemer_fail_redeemer() {
  basics.check_redeemer.spend(
    None,
    FailRedeemer,
    mock_utxo_ref(0, 0),
    placeholder,
  ) == False
}

test check_datum_success() {
  basics.check_datum.spend(
    Some(Datum1 { secret: #"cffe" }),
    RedeemerWithMessage { message: #"cffe" },
    mock_utxo_ref(0, 0),
    placeholder,
  )
}

test check_datum_fail() {
  basics.check_datum.spend(
    Some(Datum2),
    RedeemerWithMessage { message: #"cffe" },
    mock_utxo_ref(0, 0),
    placeholder,
  ) == False
}

test check_datum_fail_2() {
  basics.check_datum.spend(
    Some(Datum1 { secret: #"cffe" }),
    RedeemerWithMessage { message: "" },
    mock_utxo_ref(0, 0),
    placeholder,
  ) == False
}

test check_only_1_input_and_output_success() {
  basics.check_only_1_input_and_output.spend()
}
