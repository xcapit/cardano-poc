use cardano/transaction.{OutputReference, Transaction}
use hello_world
use types_hello_world.{Datum, Redeemer}

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
  hello_world.hello_world.spend(Some(datum), redeemer, placeholder_utxo, tx)
}
