use market/market
use mocktail/virgin_output_reference.{mock_utxo_ref}
use mocktail/virgin_key_hash.{mock_pub_key_hash,mock_policy_id}


test buy() { 
    let seller = mock_pub_key_hash(1)
    let buyer = mock_pub_key_hash(2)

    let marketDatum = MarketDatum { price: 200, seller: seller}
    let marketAction = MBuy

    let marketValue = assets.merge(
        assets.from_lovelace(600),
        assets.from_asset(mock_policy_id(1),#"testToken",1)
    )

    let oref = mock_utxo_ref(0, 0)

    let marketInput =
        Input {
            output_reference: oref,
            output: Output {
                address: Address {
                    payment_credential: #"deef",
                    stake_credential: None,
                },
                value: marketValue,
                datum: marketDatum,
                reference_script: None,
            }

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
            }

        }
    let buyerOut = 
        Output {
            address: Address {
                    payment_credential: mock_pub_key_hash(2),
                    stake_credential: None,
                },
            value: assets.from_lovelace(600),
            datum: NoDatum,
            reference_script: None,
        }
    tx = 
        Transaction {
            .. placeholder,
            inputs: [buyerIn, marketIn],
            output: [buyerOut, sellerOut]
        }
    market.market.spend(marketDatum, marketAction, oref, tx)
}
