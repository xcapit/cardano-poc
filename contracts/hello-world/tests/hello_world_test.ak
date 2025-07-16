use aiken/transaction.{OutputReference, Transaction}
use hello_world.{Datum, Redeemer, hello_world}

test hello() {
  let datum =
    Datum { owner: #"00000000000000000000000000000000000000000000000000000000" }
  let redeemer = Redeemer { msg: "a, World!" }
  let placeholder_utxo = OutputReference { transaction_id: "", output_index: 0 }
  let tx =
    transaction.Transaction {
      ..transaction.placeholder,
      extra_signatories: [datum.owner],
    }
  hello_world.spend(Some(datum), redeemer, placeholder_utxo, tx)
}
