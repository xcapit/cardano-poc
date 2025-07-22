use cardano/transaction.{Transaction, placeholder}
use gift_card/oneshot.{CheckMint}
use mocktail.{complete, mocktail_tx, required_signer_hash}
use mocktail/virgin_key_hash.{mock_policy_id, mock_pub_key_hash}

test mock_tx_mint() -> Transaction {
  mocktail_tx()
    |> mint(True,1,mock_policy_id(0),mock)
}
