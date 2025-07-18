use cardano/address.{Credential}
use cardano/assets.{PolicyId}
use cardano/certificate.{Certificate}
use cardano/governance.{ProposalProcedure, Voter}
use cardano/transaction.{OutputReference, Transaction}
use cardano/collection/list

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
    _self: Transaction,
  ) {
    when redeemer is {
      MBuy -> True
      MEdit { price } -> True
      MDelist -> {}
    }
  }
}
