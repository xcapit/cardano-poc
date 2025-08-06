use cardano/address.{Address, VerificationKey}
use cardano/assets.{from_asset, from_lovelace}
use cardano/transaction.{Input, NoDatum, Output, Transaction, placeholder}
use gift_card/oneshot.{CheckBurn, CheckMint}
use mocktail.{complete, mint, mocktail_tx, tx_in}
use mocktail/virgin_address.{mock_pub_key_address}
use mocktail/virgin_key_hash.{mock_policy_id, mock_pub_key_hash}
use mocktail/virgin_output_reference.{mock_tx_hash, mock_utxo_ref}

fn mock_tx_without_mocktail() -> Transaction {
  let input =
    Input {
      output_reference: mock_utxo_ref(0, 0),
      output: Output {
        address: Address {
          payment_credential: VerificationKey(mock_pub_key_hash(0)),
          stake_credential: None,
        },
        value: from_asset("", "", 10_000_000),
        datum: NoDatum,
        reference_script: None,
      },
    }
  Transaction {
    ..placeholder,
    mint: from_asset(mock_policy_id(0), #"cffe", 1),
    inputs: [input],
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
    |> mint(True, 1, mock_policy_id(0), #"cffe")
    |> complete()
}

fn mock_tx_with_mocktail_burn() -> Transaction {
  mocktail_tx()
    |> tx_in(
        True,
        mock_tx_hash(0),
        0,
        from_lovelace(10_000_000),
        mock_pub_key_address(0, None),
      )
    |> mint(True, -1, mock_policy_id(0), #"cffe")
    |> complete()
}

test mock_equal_tx() {
  let with_mocktail = mock_tx_with_mocktail()
  let without_mocktail = mock_tx_without_mocktail()
  with_mocktail == without_mocktail
}

test minting() {
  oneshot.gift_card.mint(
    #"cffe",
    mock_utxo_ref(0, 0),
    CheckMint,
    mock_policy_id(0),
    mock_tx_with_mocktail(),
  )
}

test burning() {
  oneshot.gift_card.mint(
    #"cffe",
    mock_utxo_ref(0, 0),
    CheckBurn,
    mock_policy_id(0),
    mock_tx_with_mocktail_burn(),
  )
}
