use cardano/address.{Address, VerificationKey}
use cardano/assets
use cardano/transaction.{
  InlineDatum, Input, NoDatum, Output, OutputReference, Transaction, placeholder,
}
use market/market.{MBuy, MarketDatum}
use mocktail/virgin_key_hash.{mock_policy_id, mock_pub_key_hash}
use mocktail/virgin_output_reference.{mock_utxo_ref}

test buy() {
  let seller = mock_pub_key_hash(1)
  let buyer = mock_pub_key_hash(2)

  let marketDatum = MarketDatum { price: 200, seller }
  let marketAction = MBuy

  let marketValue =
    assets.merge(
      assets.from_lovelace(600),
      assets.from_asset(mock_policy_id(1), mock_pub_key_hash(3), 1),
    )

  let oref = mock_utxo_ref(0, 0)

  let marketInput =
    Input {
      output_reference: oref,
      output: Output {
        address: Address {
          payment_credential: mock_pub_key_hash(2),
          stake_credential: None,
        },
        value: marketValue,
        datum: InlineDatum(marketDatum),
        reference_script: None,
      },
    }

  let buyerIn =
    Input {
      output_reference: oref,
      output: Output {
        address: Address {
          payment_credential: mock_pub_key_hash(2),
          stake_credential: None,
        },
        value: assets.from_lovelace(600),
        datum: NoDatum,
        reference_script: None,
      },
    }

  let buyerOut =
    Output {
      address: Address {
        payment_credential: mock_pub_key_hash(2),
        stake_credential: None,
      },
      value: marketValue,
      datum: None,
      reference_script: None,
    }
  let sellerOut =
    Output {
      address: Address {
        payment_credential: mock_pub_key_hash(1),
        stake_credential: None,
      },
      value: assets.from_lovelace(600),
      datum: NoDatum,
      reference_script: None,
    }

  let tx =
    Transaction {
      ..placeholder,
      inputs: [buyerIn, marketIn],
      output: [buyerOut, sellerOut],
    }
  market.market.spend(Some(marketDatum), marketAction, oref, tx)
}
