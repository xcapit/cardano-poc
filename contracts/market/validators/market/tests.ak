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
        assets.from_asset(mock_policy_id(1))
    )

    let oref = mock_utxo_ref(0, 0)
    tx = Transaction {
        .. placeholder,
        inputs: [buyerIn, marketIn],
        output: [buyerOut, sellerOut]
    }
    market.market.spend(marketDatum, marketAction, oref, tx)
}
