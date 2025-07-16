use validators.hello_world
use cardano/transaction
use cardano/transaction.OutputReference

test hello() {
  let datum =
    Datum { owner: #"00000000000000000000000000000000000000000000000000000000" }
  let redeemer = Redeemer { msg: "Hello, World!" }
  let placeholder_utxo = OutputReference { transaction_id: "", output_index: 0 }
  let tx =
    transaction.Transaction {
      ..transaction.placeholder,
      extra_signatories: [datum.owner],
    }
  hello_world.spend(Some(datum), redeemer, placeholder_utxo, tx)
}