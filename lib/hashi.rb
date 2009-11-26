module Hashi
  class CustomHash
    
    attr_reader :hash

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
      return CustomHash.new(value) if value.kind_of?(Hash) || value.kind_of?(Array)
      value
    end
    
  end
  def self.to_object(h)
    CustomHash.new(h)
  end
end