use basics/basics.{
  AnotherSuccessCase, Datum1, Datum2, FailRedeemer, RedeemerWithMessage,
  SuccessRedeemer,
}
use cardano/assets.{from_lovelace}
use cardano/transaction.{placeholder}
use mocktail.{complete, mocktail_tx, tx_in, tx_out}
use mocktail/virgin_address.{mock_pub_key_address}
use mocktail/virgin_output_reference.{mock_tx_hash, mock_utxo_ref}

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
  let tx =
    mocktail_tx()
      |> tx_in(
          True,
          mock_tx_hash(0),
          0,
          from_lovelace(10_000_000),
          mock_pub_key_address(0, None),
        )
      |> tx_out(True, mock_pub_key_address(0, None), from_lovelace(1_000_000))
      |> complete()
  basics.check_only_1_input_and_output.spend(
    None,
    Void,
    mock_utxo_ref(0, 0),
    tx,
  )
}

test check_2_inputs_and_1_output_fail() {
  let tx =
    mocktail_tx()
      |> tx_in(
          True,
          mock_tx_hash(0),
          0,
          from_lovelace(10_000_000),
          mock_pub_key_address(0, None),
        )
      |> tx_in(
          True,
          mock_tx_hash(1),
          1,
          from_lovelace(10_000_000),
          mock_pub_key_address(0, None),
        )
      |> tx_out(True, mock_pub_key_address(0, None), from_lovelace(1_000_000))
      |> complete()
  basics.check_only_1_input_and_output.spend(
    None,
    Void,
    mock_utxo_ref(0, 0),
    tx,
  ) == False
}

test check_1_input_and_2_outputs_success() {
  let tx =
    mocktail_tx()
      |> tx_in(
          True,
          mock_tx_hash(0),
          0,
          from_lovelace(10_000_000),
          mock_pub_key_address(0, None),
        )
      |> tx_out(True, mock_pub_key_address(0, None), from_lovelace(1_000_000))
      |> complete()
  basics.check_only_1_input_and_output.spend(
    None,
    Void,
    mock_utxo_ref(0, 0),
    tx,
  )
}
