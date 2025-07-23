use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction}
use vodka_extra_signatories.{key_signed}

pub fn isOwner(owner: VerificationKeyHash, tx: Transaction) -> Bool {
  if !key_signed(tx.extra_signatories, owner) {
    False
  } else {
    True
  }
}

test is_owner() {
  todo
}

test is_not_owner() {
  todo
}
