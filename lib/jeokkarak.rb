module Jeokkarak
  module Base
    def has_child(type, options={})
      resource_children[options[:as]] = type
    end
    def child_type_for(name)
      return reflect_on_association(key.to_sym ).klass if respond_to? :reflect_on_association
      resource_children[name] || Hashi
    end
    def resource_children
      @children ||= {}
      @children
    end
    def from_hash(h)
      h = h.dup
      result = self.new
      result._internal_hash = h
      h.each do |key,value|
        from_hash_parse result, h, key, value
      end
      def result.method_missing(name, *args, &block)
          Hashi.to_object(@_internal_hash).send(name, args[0], block)
      end
      result
    end
    def from_hash_parse(result,h,key,value)
      case value.class.to_s
      when 'Array'
        h[key].map! { |e| child_type_for(key).from_hash e }
      when /\AHash(WithIndifferentAccess)?\Z/
        h[key] = child_type_for(key ).from_hash value
      end
      name = "#{key}="
      result.send(name, value) if result.respond_to?(name)
    end
  end
end

module Jeokkarak
  module Config
    def acts_as_jeokkarak
      self.module_eval do
        attr_accessor :_internal_hash
      end
      self.extend Jeokkarak::Base
    end
  end
end

Object.extend Jeokkarak::Config