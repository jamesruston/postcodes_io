require 'excon'
require 'json'
require 'postcodes_io/postcode'

module Postcodes
  module Lookup


    def lookup(*postcodes)
      postcodes.flatten!
      if postcodes.count > 1
        lookup_multiple postcodes
      else
        lookup_postcode postcodes.first
      end
    end
          

    private

    def lookup_postcode(postcode)
      postcode = remove_whitespace postcode
      response = Excon.get("https://api.postcodes.io/postcodes/#{postcode}")

      unless response.status == 404
        parsed_response = JSON.parse(response.body)
        return Postcodes::Postcode.new(parsed_response['result'])
      end
      return nil
    end

    def lookup_multiple(postcodes)
      payload = {postcodes: postcodes.map {|p| remove_whitespace p}}
      response = Excon.post(
        "https://api.postcodes.io/postcodes",
         body: payload.to_json,
         headers: {'Content-Type' => 'application/json'}
         )

      process_response(response) do |r|
        return r['result'].map do |result|
          Postcodes::Postcode.new(result['result'])
        end
      end
    end

    def remove_whitespace(string)
      string.gsub(/\s+/, '') # remove any whitespace. m1 1ab => m11ab
    end

    def process_response(response, &block)
      unless response.status == 404
        yield JSON.parse(response.body)
      end
      nil
    end

  end
end
