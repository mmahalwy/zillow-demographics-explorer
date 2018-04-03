class ZillowController < ApplicationController
  def neighborhood
  end

  def demographics
    zester = Zester::Client.new(ENV.fetch(:ZILLOW_KEY), 5)

    @data = zester.neighborhood.demographics(set_params).to_hash.deep_symbolize_keys
    @neighborhoods = zester.neighborhood.region_children(set_params.merge('childtype' => 'neighborhood')).to_hash.deep_symbolize_keys
    @zipcodes = zester.neighborhood.region_children(set_params.merge('childtype' => 'zipcode')).to_hash.deep_symbolize_keys
  end

  def set_params
    params.permit(:state, :city, :regionId).as_json
  end
end
