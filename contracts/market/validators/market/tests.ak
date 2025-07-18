use market/market
use mocktail/virgin_output_reference.{mock_utxo_ref}


test buy() { 
    let oref = mock_utxo_ref(0, 0)
    tx = Transaction {
        .. placeholder,
        inputs: [buyerIn, marketIn],
        output: [buyerOut, sellerOut]
    }
    market.market.spend(marketDatum, marketAction, oref, tx)
}
