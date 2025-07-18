use cardano/assets.{PolicyId}
use cardano/collection/list
use cardano/transaction.{OutputReference, Transaction}

pub type MarketDatum {
  price: Int,
  seller: ByteArray,
}

pub type MarketAction {
  MBuy
  MEdit { price: Int }
  MDelist
}

validator placeholder {
  mint(_redeemer: Data, _policy_id: PolicyId, _self: Transaction) {
    todo @"mint logic goes here"
  }

  spend(
    datum: Option<MarketDatum>,
    redeemer: MarketAction,
    _utxo: OutputReference,
    tx: Transaction,
  ) {
    when redeemer is {
      MBuy -> True
      MEdit { price } -> True
      MDelist -> list.has(self)
    }
  }

  else(_) {
    fail
  }
}
