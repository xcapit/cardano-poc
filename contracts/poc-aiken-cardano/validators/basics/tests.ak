use basics/basics.{ SuccessRedeemer, AnotherSuccessCase}
use mocktail/virgin_output_reference.{mock_utxo_ref}
use cardano/transaction.{placeholder}

test basics_sucess(){
    basics.basics.spend(None,SuccessRedeemer, mock_utxo_ref(0,0), placeholder)
}
test basics_sucess_2(){
    basics.basics.spend(None,AnotherSuccessCase, mock_utxo_ref(0,0), placeholder)
}
test basics_fail(){
    
}