use basics/basics.{ SuccessRedeemer }
use mocktail/virgin_output_reference.{mock_utxo_ref}

test basics_sucess(){
    basics.basics.spend(None,SuccessRedeemer, mock_utxo_ref(0,0), )
}