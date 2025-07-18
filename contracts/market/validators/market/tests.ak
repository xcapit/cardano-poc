use market/market
use mocktail/virgin_output_reference.{mock_utxo_ref}
use mocktail/virgin_key_hash.{mock_pub_key_hash}


test buy() { 
    let seller = mock_pub_key_hash(1)
    let buyer = mock_pub_key_hash(2)

    let marketDatum = MarketDatum { price: 200, seller: seller}
    let marketAction = MBuy

    let oref = mock_utxo_ref(0, 0)
    tx = Transaction {
        .. placeholder,
        inputs: [buyerIn, marketIn],
        output: [buyerOut, sellerOut]
    }
    market.market.spend(marketDatum, marketAction, oref, tx)
}
