use market/market

test buy() { 
    tx = Transaction {
        .. placeholder,
        inputs: [],
        output: []
    }
    market.market.spend(marketDatum, marketAction, oref, tx)
}
