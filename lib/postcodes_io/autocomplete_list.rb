require "postcodes_io/base"

module Postcodes
  class AutocompleteList < Base

    attr_reader :list

    def initialize(list)
      @list = list
    end
  end
end
