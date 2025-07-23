pub type Datum {
  TotalSupply { count: Int }
}

const token_name = "Xcapit"

const token_symbol = "Xc"

validator token {
  else(_) {
    fail
  }
}
