use aiken/assert
use cardano/transaction.{OutputReference, Transaction}
use validators/hello_world.{Datum, Redeemer, hello_world}

pub fn debug_test() {
  let test_result = hello_world_test()
  assert.ok(test_result, "Test failed!")
}

test hello_world_test() {
  let datum =
    Datum { owner: #"00000000000000000000000000000000000000000000000000000000" }
  let redeemer = Redeemer { msg: "Hello, World!" }
  let placeholder_utxo = OutputReference { transaction_id: "", output_index: 0 }
  let tx =
    Transaction { ..Transaction.placeholder, extra_signatories: [datum.owner] }
  hello_world.spend(Some(datum), redeemer, placeholder_utxo, tx)
}
