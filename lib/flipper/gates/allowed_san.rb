module Flipper
  module Gates
    class AllowedSan < Gate
      # Internal: The name of the gate. Used for instrumentation, etc.
      def name
        :allowed_san
      end

      # Internal: Name converted to value safe for adapter.
      def key
        :allowed_sans
      end

      def data_type
        :set
      end

      def enabled?(value)
        !value.empty?
      end

      # Internal: Checks if the gate is open for a thing.
      #
      # Returns true if gate open for thing, false if not.
      def open?(context)
        value = context.values[key]
        if context.thing.nil?
          false
        else
          if protects?(context.thing)
            san = wrap(context.thing)
            enabled_sans = value
            enabled_sans.include?(san.value)
          else
            false
          end
        end
      end

      def wrap(thing)
        Types::AllowedSan.wrap(thing)
      end

      def protects?(thing)
        Types::AllowedSan.wrappable?(thing)
      end
    end
  end
end
