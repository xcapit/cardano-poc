use market/market

test buy() { 
    tx = Transaction {
        .. placeholder,
        inputs: [buyerIn, marketIn],
        output: [buyerOut, sellerOut]
    }
    market.market.spend(marketDatum, marketAction, oref, tx)
}
