require "postcodes_io/version"
require "postcodes_io/lookup"
require "postcodes_io/autocomplete"
require "postcodes_io/postcode"

module Postcodes
  class IO
    include Lookup
    include Autocomplete
  end
end
