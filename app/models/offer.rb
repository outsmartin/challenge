require 'active_model'
class Offer
  include ActiveModel::Validations
  def self.api_key
    'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'
  end

  def self.valid? response
    checksum = Digest::SHA1.hexdigest(response.body.to_s + api_key)
    checksum == response.headers[:x_sponsorpay_response_signature]
  end

  def initialize params={}
    @params = Hash[params.select{|k,v| ["uid","pub0","page"].include? k}]
    @default_params = {
    'appid' => 157,
    'device_id' => '2b6f0cc904d137be2e1730235f5664094b831186',
    'locale' => 'de',
    'ip' => '109.235.143.113',
    'offer_types' => 112,
    'timestamp' => Time.now.to_i
    }
  end

  def to_params_with_hash
    to_params.merge({hashkey: hash})
  end

  def to_params
    @default_params.merge(@params)
  end

  def hash
    Digest::SHA1.hexdigest("#{to_sorted_params.to_query}&#{Offer.api_key}")
  end

  def to_sorted_params
    Hash[to_params.sort]
  end
end
