use cardano/transaction.{Transaction, placeholder}
use mocktail/virgin_key_hash.{mock_pub_key_hash}
use opz/opz

const owner = mock_pub_key_hash(0)

const other = mock_pub_key_hash(1)

pub fn mock_tx_with_sign_owner() {
  Transaction { ..placeholder, extra_signatories: [owner] }
}

pub fn mock_tx_with_sign_owner() {
  Transaction { ..placeholder, extra_signatories: [other] }
}

test is_owner() {
  let tx = mock_tx_with_sign_owner()
  opz.isOwner(tx, owner)
}

test is_not_owner() {
  let tx = mock_tx_with_sign_owner()
  opz.isOwner(tx, owner)
}
