require 'excon'
require 'json'
require 'postcodes_io/postcode'

module Postcodes
  module ReverseGeocode
    def reverse_geocode(longitude:, latitude:)
      response = Excon.get(
        "https://api.postcodes.io/postcodes?lon=#{longitude}&lat=#{latitude}")
      return unless response.status == 200

      json = JSON.parse(response.body)
      return unless json['result']

      json['result'].map do |result|
        Postcode.new(result)
      end
    end
  end
end
