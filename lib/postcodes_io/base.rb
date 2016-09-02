module Postcodes
  class Base
    # allow accessing info values with dot notation
    def method_missing(name, *args, &block)
      return @info[name.to_s] if @info.key? name.to_s
      return @info[name] if @info.key? name
      super.method_missing name
    end
  end
end
