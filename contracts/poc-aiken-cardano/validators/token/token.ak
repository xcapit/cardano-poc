pub type Datum {
  TotalSupply { count: Int }
}

const token_name = "Xcapit"

validator token {
  else(_) {
    fail
  }
}
