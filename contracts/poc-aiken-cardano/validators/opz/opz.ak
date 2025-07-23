use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction}

pub fn only_owner(owner: VerificationKeyHash, tx: Transaction) {
  key_signed(tx.extra_signatories, owner)
}
