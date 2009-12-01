module Chokara
  module Base
    def to_object(h)
      Hashi::CustomHash.new(h)
    end
  end
end