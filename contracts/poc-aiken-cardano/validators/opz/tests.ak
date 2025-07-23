use cardano/transaction.{Transaction, placeholder}
use mocktail/virgin_key_hash.{mock_pub_key_hash}
use opz/opz

pub fn mock_tx_with_sign_owner() {
  Transaction { ..placeholder, extra_signatories: [owner] }
}

pub fn mock_tx_with_sign_other() {
  Transaction { ..placeholder, extra_signatories: [other] }
}

test is_owner() {
  let tx = mock_tx_with_sign_owner()
  opz.isOwner(tx, owner)
}

test is_not_owner() {
  let tx = mock_tx_with_sign_other()
  opz.isOwner(tx, owner) == False
}
