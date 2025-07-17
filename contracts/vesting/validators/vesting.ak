use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}
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

test vesting_owner() {
  let datum = Datum {lock_until: 10000, owner:#"00000000000000000000000000000000000000000000000000000000", beneficiary:#"00000000000000000000000000000000000000000000000000000000" }
  let tx 
  vesting.spend()
}
