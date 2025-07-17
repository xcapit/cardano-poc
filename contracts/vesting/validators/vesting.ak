use aiken/crypto.{VerificationKeyHash}
use cardano/transaction.{OutputReference, Transaction}
use mocktail.{complete, invalid_before, mocktail_tx, required_signer_hash}
use mocktail/virgin_key_hash.{mock_pub_key_hash}
use mocktail/virgin_output_reference.{mock_utxo_ref}
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

type TestCase {TestCase}

fn vesting_datum() {
  VestingDatum {
    lock_until: 10000,
    owner: mock_pub_key_hash(1),
    beneficiary: mock_pub_key_hash(2),
  }
}

test vesting_owner() {
  let datum = vesting_datum()
  let utxo = mock_utxo_ref(0, 0)

  let tx =
    transaction.Transaction {
      ..transaction.placeholder,
      extra_signatories: [datum.owner],
    }
  vesting.spend(Some(datum), None, utxo, tx)
}

type TestCase {
  is_owner_signed: Bool,
  is_beneficiary_signed: Bool,
  is_lock_time_passed: Bool,
}

fn get_test_tx(test_case: TestCase) {
  let TestCase { is_owner_signed, is_beneficiary_signed, is_lock_time_passed } =
    test_case
  mocktail_tx()
    |> required_signer_hash(is_owner_signed, mock_pub_key_hash(1))
    |> required_signer_hash(is_beneficiary_signed, mock_pub_key_hash(2))
    |> invalid_before(is_lock_time_passed, 10001)
    |> complete()
}

test vesting_owner_mocktail() {
  let datum = Some(vesting_datum())
  let test_case =
    TestCase {
      is_owner_signed: True,
      is_beneficiary_signed: True,
      is_lock_time_passed: True,
    }
  let out_ref = mock_utxo_ref(0, 0)
  let tx = get_test_tx(test_case)
  vesting.spend(datum, Void, out_ref, tx)
}
