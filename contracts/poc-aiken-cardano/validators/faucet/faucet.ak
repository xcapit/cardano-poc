pub type Datum {
  TotalSupply { count: Int }
}

const token = "Xcapit"

validator faucet {
  else(_) {
    fail
  }
}
