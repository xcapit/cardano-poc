use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction, ValidityRange}
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
  let datum =
    VestingDatum {
      lock_until: 10000,
      owner: #"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      beneficiary: #"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
    }
  let tx =
    transaction.Transaction {
      ..transaction.placeholder,
      extra_signatories: [datum.owner],
    }
  let utxo = OutputReference { transaction_id: "", output_index: 0 }
  vesting.spend(Some(datum), None, utxo, tx)
}

test vesting_beneficiary() {
  let datum =
    VestingDatum {
      lock_until: 10000,
      owner: #"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      beneficiary: #"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
    }
  let tx =
    transaction.Transaction {
      ..transaction.placeholder,
      extra_signatories: [datum.beneficiary],
      validity_range: ValidityRange {
        lower: Some(datum.lock_until + 1),
        upper: None,
      },
    }
  let utxo = OutputReference { transaction_id: "", output_index: 0 }
  vesting.spend(Some(datum), None, utxo, tx)
}
