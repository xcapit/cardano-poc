pub type Datum {
  TotalSupply { count: Int }
}

const token = "Xcapit"

validator token {
  else(_) {
    fail
  }
}
