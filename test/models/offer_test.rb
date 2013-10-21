require 'test_helper'

describe Offer do
  it "should give params" do
    offer = Offer.new( uid: 'player1', pub0: 'test', page: 0)
    offer.to_params.must_be_kind_of Hash
  end

  it "should calc hash" do
    offer = Offer.new( uid: 'player1', pub0: 'test', page: 0)
    offer.hash.must_be_kind_of String
    offer.hash.length.must_equal 40
  end

  it "should validate response" do
    body = '{"code":"NO_CONTENT","message":"Successful request, but no offers are currently available for this user.","count":0,"pages":0,"information":{"app_name":"Demo iframe for publisher - do not touch","appid":157,"virtual_currency":"Coins","country":"DE","language":"DE","support_url":"http://api.sponsorpay.com/support?appid=157&feed=on&mobile=on&uid=player"},"offers":[]}'
    valid_checksum = 'c080feef66cffa8624ece1780e9b1a9ba80170a7'
    invalid_checksum = 'd080feef66cffa8624ece1780e9b1a9ba80170a7'

    Response = Struct.new(:body, :headers)
    response_valid = Response.new(body, x_sponsorpay_response_signature: valid_checksum)
    response_invalid = Response.new(body, x_sponsorpay_response_signature: invalid_checksum)
    Offer.valid?(response_valid).must_equal true
    Offer.valid?(response_invalid).must_equal false
  end

end
