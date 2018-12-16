Payments#zion_info
params => id=0033E3B0DA7F4867166FCB43FBB0FF0F.uat01-vm-tx04&
resourcePath=%2Fv1%2Fcheckouts%2F0033E3B0DA7F4867166FCB43FBB0FF0F.uat01-vm-tx04%2Fpayment
    {
  "result":{
    "code":"200.300.404",
    "description":"invalid or missing parameter - (opp) No payment session found for the requested id - are you mixing test/live servers or have you paid more than 30min ago?"
  },
  "buildNumber":"7469d0e5bd2dccca50bbd107625279e76a2c9ff3@2018-12-04 10:59:49 +0000",
  "timestamp":"2018-12-05 16:13:13+0000",
  "ndc":"8a8294174b7ecb28014b9699220015ca_844fa63b992e44a393277185e4aa7b2b"
}
OR
{"id"=>"8ac7a4a067839980016792dded4262d3",
 "paymentType"=>"DB",
 "paymentBrand"=>"VISA",
 "amount"=>"79.00",
 "currency"=>"EUR",
 "descriptor"=>"7808.7406.6650 OPP_Channel",
 "result"=>{"code"=>"000.100.110",
 "description"=>"Request successfully processed in 'Merchant in Integrator Test Mode'"},
 "resultDetails"=>{"clearingInstituteName"=>"Elavon-euroconex_UK_Test"},
 "card"=>{"bin"=>"424242",
 "last4Digits"=>"4242",
 "holder"=>"g jone",
 "expiryMonth"=>"10",
 "expiryYear"=>"2020"},
 "customer"=>{"ip"=>"90.255.34.185"},
 "threeDSecure"=>{"eci"=>"06"},
 "customParameters"=>
  {"SHOPPER_EndToEndIdentity"=>"d95bac02e2d53d131c7954394303d240e90e9fce42ca45524e1f8ea81b88e6ac",
   "CTPE_DESCRIPTOR_TEMPLATE"=>""},
 "risk"=>{"score"=>"0"},
 "buildNumber"=>"7469d0e5bd2dccca50bbd107625279e76a2c9ff3@2018-12-04 10:59:49 +0000",
 "timestamp"=>"2018-12-09 12:07:57+0000",
 "ndc"=>"2566E07E65A85084A02847E93895A323.uat01-vm-tx04"}
