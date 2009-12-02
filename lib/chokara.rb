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
          puts "will try #{name} #{args} #{block}"
          result = Hashi.to_object(@_internal_hash).send(name, args, block)
          puts "ha! missing #{name} is #{result}"
          result
        end
      end
#      if !(links.nil?) && self.include?(Restfulie::Client::Instance)
#        result.add_transitions(links)
#      end
      result
    end
  end
end