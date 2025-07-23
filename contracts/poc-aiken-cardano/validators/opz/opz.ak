use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction}
use vodka_extra_signatories.{key_signed}

const owner = mock_pub_key_hash(0)

const other = mock_pub_key_hash(1)

pub fn isOwner(tx: Transaction, owner: VerificationKeyHash) -> Bool {
  key_signed(tx.extra_signatories, owner)
}

pub fn owner() {
  todo
}
