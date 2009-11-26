module Hashie
  class CustomObject

    def initialize(h)
      @hash = h
    end
    def method_missing(name, *args)
      name = name.to_s if name.kind_of? Symbol
      if name[-1,1] == "="
        name = name.chop
        @hash[name] = args[0]
      else
        transform(@hash[name])
      end
    end
    def [](x)
      transform(@hash[x])
    end
    private
    def transform(value)
      return CustomObject.new(value) if value.kind_of?(Hash) || value.kind_of?(Array)
      value
    end
  end
  def self.hash_to_object(h)
    CustomObject.new(h)
  end
end