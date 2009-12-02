module Jeokkarak
  module Base
    def has_child(type, options={})
      resource_children[options[:as]] = type
    end
    def child_type_for(name)
      resource_children[name] || Hashi
    end
    def resource_children
      @children ||= {}
      @children
    end
    def from_hash(h)
      h = h.dup
      links = nil
      result = self.new
      result._internal_hash = h
      h.each do |key,value|
        if respond_to? :reflect_on_association
          case value.class.to_s
          when 'Array'
            h[key].map! { |e| reflect_on_association(key.to_sym ).klass.from_hash e }
          when /\AHash(WithIndifferentAccess)?\Z/
            h[key] = reflect_on_association(key.to_sym ).klass.from_hash value
          end
        elsif
          case value.class.to_s
          when 'Array'
            h[key].map! { |e| child_type_for(key ).from_hash e }
          when /\AHash(WithIndifferentAccess)?\Z/
            h[key] = child_type_for(key ).from_hash value
          end
        end
        name = "#{key}="
        result.send(name, value) if result.respond_to?(name)
        def result.method_missing(name, *args, &block)
            Hashi.to_object(@_internal_hash).send(name, args[0], block)
        end
      end
#      if !(links.nil?) && self.include?(Restfulie::Client::Instance)
#        result.add_transitions(links)
#      end
      result
    end
  end
end