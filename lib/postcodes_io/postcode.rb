module Postcodes
  class Postcode

    attr_reader :info

    def initialize(info)
      @info = info
    end

    # allow accessing info values with dot notation
    def method_missing(name, *args, &block)
      return @info[name] if @info.key? name
      @info.each { |k,v| return v if k.to_s.to_sym == name }
      super.method_missing name
    end
  end
end
