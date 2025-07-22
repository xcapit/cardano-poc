use cardano/assets.{from_asset}
use cardano/transaction.{Transaction, placeholder}
use gift_card/oneshot.{CheckMint}
use mocktail.{complete, mocktail_tx}
use mocktail/virgin_key_hash.{mock_policy_id}

fn mock_tx_without_mocktail() -> Transaction {
  Transaction {
    ..placeholder,
    mint: from_asset(mock_policy_id(0), "test token name", 1),
  }
}

fn mock_tx_mint() -> Transaction {
  mocktail_tx()
    |> mint(True, 1, mock_policy_id(0), "test token name")
    |> complete()
}
