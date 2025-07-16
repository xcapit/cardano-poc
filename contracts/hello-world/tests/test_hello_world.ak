test module test_hello_world
use validators.hello_world
use cardano/transaction
use cardano/transaction.OutputReference

test "hello_world accepts correct msg and signer" {
  let datum =
    hello_world.Datum { owner: #"00000000000000000000000000000000000000000000000000000000" }
  let redeemer = hello_world.Redeemer { msg: "Hellos, World!" }
  let placeholder_utxo = OutputReference { transaction_id: "", output_index: 0 }
  let tx =
    transaction.Transaction {
      ..transaction.placeholder,
      extra_signatories: [datum.owner],
    }
  hello_world.spend(
    Some(datum),
    redeemer,
    placeholder_utxo,
    tx,
  )
}
