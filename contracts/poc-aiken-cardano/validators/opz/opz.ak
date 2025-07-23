use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction}
use vodka_extra_signatories.{key_signed}

pub fn only_owner(owner: VerificationKeyHash, tx: Transaction) {
  key_signed(tx.extra_signatories, owner)
}
