use aiken/collection/list
use aiken/crypto.{VerificationKeyHash}
use aiken/primitive/string
use cardano/transaction.{OutputReference, Transaction}
use mocktail/virgin_key_hash.{mock_pub_key_hash}
use mocktail/virgin_output_reference.{mock_utxo_ref}

pub type Datum {
  owner: VerificationKeyHash,
}

pub type Redeemer {
  msg: ByteArray,
}

validator hello_world {
  spend(
    datum: Option<Datum>,
    redeemer: Redeemer,
    _own_ref: OutputReference,
    self: Transaction,
  ) {
    trace @"redeemer": string.from_bytearray(redeemer.msg)
    expect Some(Datum { owner }) = datum
    let must_say_hello = redeemer.msg == "Hello, World!"
    let must_be_signed = list.has(self.extra_signatories, owner)
    must_say_hello? && must_be_signed?
  }

  else(_) {
    fail
  }
}
