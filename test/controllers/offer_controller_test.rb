require "test_helper"

describe OfferController do
  it "should get index" do
    get :index
    assert_response :success
  end

  describe "api" do
    before do
      time = Time.parse("2013-10-21 15:11:29 +0200")
      Timecop.freeze(time)
    end
    it "should get empty offers if no offer present for request" do
      VCR.use_cassette('no_offers') do
        get :api,  uid: 'player1', pub0: 'test', page: 1
        response.body.must_be :=~,/No offers/
      end
    end
  end

end
