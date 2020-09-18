# Simple class for turning a flipper_id into a SAN that can be based
# to Flipper::Feature#enabled?.
module Flipper
  class AllowedSan
    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def eql?(other)
      self.class.eql?(other.class) && @domain == other.domain
    end
    alias_method :==, :eql?
  end
end
