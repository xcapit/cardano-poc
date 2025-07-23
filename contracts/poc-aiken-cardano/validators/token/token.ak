pub type Datum {
  TotalSupply { count: Int }
}

const token_name = "Xcapit"

const symbol = "Xc"

validator token {
  else(_) {
    fail
  }
}
