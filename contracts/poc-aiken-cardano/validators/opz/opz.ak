use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction}
use vodka_extra_signatories.{key_signed}

pub fn isOwner(owner: VerificationKeyHash, tx: Transaction) -> Bool {
  key_signed(tx.extra_signatories, owner)
}
