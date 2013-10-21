class OfferController < ApplicationController
  def index
  end

  def api
    offer = Offer.new params
    url = 'http://api.sponsorpay.com/feed/v1/offers.json'
    RestClient.get(url,params: offer.to_params_with_hash){|response,request,result|
      @response = response
      @request = request
    }
    parsed_response = JSON.parse @response
    @message = parsed_response["message"]

    case response.code
    when 200
      if Offer.valid?(@response)
        @offers = parsed_response["offers"]
        render 'index'
      else
        @message = "Invalid response, checksums did not match!"
        render 'index'
      end
    else
      render 'index'
    end

  end
end
