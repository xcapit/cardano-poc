use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{Transaction}
use vodka_extra_signatories.{key_signed}

/// Devuelve `True` si el owner firmó la transacción.
pub fn isOwner(tx: Transaction, owner: VerificationKeyHash) -> Bool {
  key_signed(tx.extra_signatories, owner)
}
