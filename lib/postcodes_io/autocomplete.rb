require 'excon'
require 'json'
require 'postcodes_io/autocomplete_list'

module Postcodes
  module Autocomplete

    def autocomplete(postcode)
      autocomplete_postcode postcode
    end

    private

    def autocomplete_postcode(postcode)
      postcode = remove_whitespace postcode
      response = Excon.get("https://api.postcodes.io/postcodes/#{postcode}/autocomplete")

      unless response.status == 404
        parsed_response = JSON.parse(response.body)
        return Postcodes::AutocompleteList.new(parsed_response['result'])
      end
      return nil
    end

    def remove_whitespace(string)
      string.gsub(/\s+/, '')
    end

    def process_response(response, &block)
      unless response.status == 404
        yield JSON.parse(response.body)
      end
      nil
    end

  end
end
