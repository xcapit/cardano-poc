use cardano/transaction.{Transaction, placeholder}
use mocktail/virgin_key_hash.{mock_pub_key_hash}
use opz/opz

const owner = mock_pub_key_hash(0)

fn mock_tx_with_sign_owner() {
  Transaction { ..placeholder, extra_signatories: [owner] }
}

fn mock_tx_without_sign_owner() {
  todo
}

test is_owner() {
  let tx = mock_tx_with_sign_owner()
  opz.isOwner()
}

test is_not_owner() {
  opz.isOwner()
}
