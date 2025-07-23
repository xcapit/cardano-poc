pub type Datum {
  TotalSupply { count: Int }
}

const pub token_name = "Xcapit"

validator token {
  else(_) {
    fail
  }
}
