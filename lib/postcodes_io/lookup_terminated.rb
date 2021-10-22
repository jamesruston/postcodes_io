require 'excon'
require 'json'
require 'postcodes_io/postcode'

module Postcodes
  module LookupTerminated
    def lookup_terminated(postcode)
      lookup_terminated_postcode postcode
    end

    private

    def lookup_terminated_postcode(postcode)
      postcode = remove_whitespace postcode
      response = Excon.get("https://api.postcodes.io/terminated_postcodes/#{postcode}")

      unless response.status == 404
        parsed_response = JSON.parse(response.body)
        return Postcodes::Postcode.new(parsed_response['result'])
      end
      nil
    end

    def remove_whitespace(string)
      string.gsub(/\s+/, '') # remove any whitespace. m1 1ab => m11ab
    end

    def process_response(response)
      yield JSON.parse(response.body) unless response.status == 404
      nil
    end
  end
end
