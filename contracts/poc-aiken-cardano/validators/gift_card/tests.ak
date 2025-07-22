use cardano/transaction.{Transaction, placeholder}
use gift_card/oneshot.{CheckMint}
use mocktail.{complete, mocktail_tx,}
use mocktail/virgin_key_hash.{mock_policy_id}

test mock_tx_mint() -> Transaction {
  mocktail_tx()
    |> mint(True,1,mock_policy_id(0),mock)
}
