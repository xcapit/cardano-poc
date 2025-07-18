use aiken/collection/list
use cardano/address.{VerificationKey}
use cardano/assets
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
  spend(
    datum: Option<MarketDatum>,
    redeemer: MarketAction,
    _utxo: OutputReference,
    tx: Transaction,
  ) {
    expect Some(d) = datum
    when redeemer is {
      MBuy -> {
        //output to seller address
        expect Some(payment) =
          list.find(
            tx.outputs,
            fn(output) {
              output.address.payment_credential == VerificationKey(d.seller)
            },
          )
        //payment value is correct
        assets.lovelace_of(payment.value) == d.price
      }
      MEdit { price } -> True
      MDelist -> list.has(tx.extra_signatories, d.seller)
    }
  }

  else(_) {
    fail
  }
}
