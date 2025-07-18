use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}
use mocktail.{complete, invalid_before, mocktail_tx, required_signer_hash}
use vodka_extra_signatories.{key_signed}
use vodka_validity_range.{valid_after}

pub type VestingDatum {
  lock_until: Int,
  owner: VerificationKeyHash,
  beneficiary: VerificationKeyHash,
}

validator vesting {
  spend(
    datum_opt: Option<VestingDatum>,
    _redeemer: Data,
    _utxo: OutputReference,
    tx: Transaction,
  ) {
    expect Some(datum) = datum_opt
    or {
      key_signed(tx.extra_signatories, datum.owner),
      and {
        key_signed(tx.extra_signatories, datum.beneficiary),
        valid_after(tx.validity_range, datum.lock_until),
      },
    }
  }

  else(_) {
    fail
  }
}
