use cardano/assets.{from_asset, from_lovelace}
use cardano/transaction.{Transaction, placeholder}
use gift_card/oneshot.{CheckMint}
use mocktail.{
  add_input, add_output, complete, mint, mock_pub_key_address, mock_pub_key_hash,
  mock_pub_key_output, mock_tx_hash, mock_utxo_ref, mocktail_tx, set_fee, tx_in,
  tx_in, tx_out,
}
use mocktail/virgin_key_hash.{mock_policy_id}
use mocktail/virgin_output_reference.{mock_utxo_ref}

fn mock_tx_without_mocktail() -> Transaction {
  Transaction {
    ..placeholder,
    mint: from_asset(mock_policy_id(0), "test token name", 1),
  }
}

fn mock_tx_with_mocktail() -> Transaction {
  mocktail_tx()
    |> tx_in(
        True,
        mock_tx_hash(0),
        0,
        from_lovelace(10_000_000),
        mock_pub_key_address(0, None),
      )
    |> mint(True, 1, mock_policy_id(0), "test token name")
    |> complete()
}

test mock_equal_tx() {
  let with_mocktail = mock_tx_with_mocktail()
  let without_mocktail = mock_tx_without_mocktail()
  with_mocktail == without_mocktail
}

test minting() {
  oneshot.gift_card.mint(
    "test token name",
    mock_utxo_ref(0, 0),
    CheckMint,
    mock_policy_id(0),
    mock_tx_with_mocktail(),
  )
}
