module Chokara
  module Base
    def from_hash(h)
      #      Hashi::CustomHash.new(h)
      h = h.dup
      links = nil
      h.each do |key,value|
        case value.class.to_s
        when 'Array'
          h[key].map! { |e| reflect_on_association(key.to_sym ).klass.from_hash e }
        when /\AHash(WithIndifferentAccess)?\Z/
          h[key] = reflect_on_association(key.to_sym ).klass.from_hash value
        end
      end
      result = self.new
      h.each do |key, value|
        result.send("#{key}=",value) if result.respond_to?("#{key}=")
      end
#      if !(links.nil?) && self.include?(Restfulie::Client::Instance)
#        result.add_transitions(links)
#      end
      result
    end
  end
end