module Chokara
  module Base
    def from_hash(h)
      #      Hashi::CustomHash.new(h)
      h = h.dup
      links = nil
      result = self.new
      result._internal_hash = h
      h.each do |key,value|
        case value.class.to_s
        when 'Array'
          h[key].map! { |e| reflect_on_association(key.to_sym ).klass.from_hash e }
        when /\AHash(WithIndifferentAccess)?\Z/
          h[key] = reflect_on_association(key.to_sym ).klass.from_hash value
        end
        name = "#{key}="
        result.send(name, value) if result.respond_to?(name)
        def result.method_missing(name, *args, &block)
          if name.to_s[-1,1]=='!='
            name.to_schop
          else
            result = Hashi.to_object(@_internal_hash).send(name, args[0], block)
            puts "result is after #{name} #{@_internal_hash}"
            result
          end
        end
      end
#      if !(links.nil?) && self.include?(Restfulie::Client::Instance)
#        result.add_transitions(links)
#      end
      result
    end
  end
end