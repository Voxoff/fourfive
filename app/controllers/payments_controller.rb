class PaymentsController < ApplicationController

  def new
    require 'net/https'
    require 'uri'
    require 'json'
    uri = URI('https://test.oppwa.com/v1/checkouts')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({
      'authentication.userId' => '8a8294174b7ecb28014b9699220015cc',
      'authentication.password' => 'sy6KJsT8',
      'authentication.entityId' => '8a8294174b7ecb28014b9699220015ca',
      # user 8ac7a4c866f2eab20166f9151d3f0ad5
      # password Cyafbt5J7a
      # entity 8ac7a4c866f2eab20166f91c44630b10
      'amount' => '92.00',
      'currency' => 'EUR',
      'paymentType' => 'DB'
    })
    res = http.request(req)
    @result = JSON.parse(res.body)
    @checkoutId = @result["id"]
  end

#   "result":{
#     "code":"000.200.100",
#     "description":"successfully created checkout"
#   },
#   "buildNumber":"49725d9aff046abbdc8fa9d5f2054425e35a91b5@2018-11-09 11:57:41 +0000",
#   "timestamp":"2018-11-10 13:57:25+0000",
#   "ndc":"650576A89D6589ED640F72D326515207.uat01-vm-tx01",
#   "id":"650576A89D6589ED640F72D326515207.uat01-vm-tx01"
# }
end
