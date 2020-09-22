module Flipper
  module Types
    class AllowedSan < Type
      def self.wrappable?(thing)
        return false if thing.nil?
        thing.respond_to?(:domain)
      end

      attr_reader :thing

      def initialize(thing)
        raise ArgumentError, 'thing cannot be nil' if thing.nil?

        unless thing.respond_to?(:domain)
          raise ArgumentError, "#{thing.inspect} must respond to domain, but does not"
        end

        @thing = thing
        @value = thing.domain.to_s
      end

      def respond_to?(*args)
        super || @thing.respond_to?(*args)
      end

      def method_missing(name, *args, &block)
        @thing.send name, *args, &block
      end
    end
  end
end
