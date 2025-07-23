use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction}
use vodka_extra_signatories.{key_signed}

pub fn isOwner(tx: Transaction, owner: VerificationKeyHash) -> Bool {
  key_signed(tx.extra_signatories, owner)
}
