require 'excon'
require 'json'
require 'postcodes_io/postcode'

module Postcodes
  module Validate
    def validate(postcode)
      validate_postcode(postcode)
    end

    private

    def validate_postcode(postcode)
      postcode = remove_whitespace postcode
      response = Excon.get("https://api.postcodes.io/postcodes/#{postcode}/validate")

      unless response.status == 404
        parsed_response = JSON.parse(response.body)
        return parsed_response['result'] == true
      end
      return nil
    end

    def remove_whitespace(string)
      string.gsub(/\s+/, '') # remove any whitespace. m1 1ab => m11ab
    end
  end
end
