require 'excon'
require 'json'
require 'postcodes_io/postcode'

module Postcodes
  module Lookup
    def lookup(postcode)
      postcode.gsub!(/\s+/, '') # remove any whitespace. m1 1ab => m11ab
      response = Excon.get("https://api.postcodes.io/postcodes/#{postcode}")
      unless response.status == 404
        parsed_response = JSON.parse(response.body)
        return Postcodes::Postcode.new(parsed_response['result'])
      end
      return nil
    end
  end
end
