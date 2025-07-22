use cardano/transaction.{Transaction, placeholder}
use gift_card/oneshot.{CheckMint}
use mocktail.{complete, mocktail_tx}
use mocktail/virgin_key_hash.{mock_policy_id}
use cardano/assets.{from_asset}


fn mock_tx_without_mocktail() -> Transaction {
  Transaction {
    ..placeholder,
    mint: from_asset(mock_policy_id(0), "test token name", 1),
  }
}

test mock_tx_mint() -> Transaction {
  let tx = mock_tx_without_mocktail()
  tx == mocktail_tx()
    |> mint(True,1,mock_policy_id(0),"test token name")
    |> complete()
}