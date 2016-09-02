require "postcodes_io/base"

module Postcodes
  class Postcode < Base

    attr_reader :info

    def initialize(info)
      @info = info
    end
  end
end
