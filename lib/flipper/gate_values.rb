require 'set'
require 'flipper/typecast'

module Flipper
  class GateValues
    # Private: Array of instance variables that are readable through the []
    # instance method.
    LegitIvars = {
      'boolean' => '@boolean',
      'actors' => '@actors',
      'actors_count' => '@actors_count',
      'groups' => '@groups',
      'percentage_of_time' => '@percentage_of_time',
      'percentage_of_actors' => '@percentage_of_actors',
      'allowed_sans' => '@allowed_sans',
    }.freeze

    attr_reader :boolean
    attr_reader :actors
    attr_reader :actors_count
    attr_reader :groups
    attr_reader :percentage_of_actors
    attr_reader :percentage_of_time
    attr_reader :allowed_sans

    def initialize(adapter_values)
      @actors_count = Typecast.to_integer(adapter_values[:actors_count])
      @boolean = Typecast.to_boolean(adapter_values[:boolean])
      @actors = Typecast.to_set(adapter_values[:actors])
      @groups = Typecast.to_set(adapter_values[:groups])
      @percentage_of_actors = Typecast.to_percentage(adapter_values[:percentage_of_actors])
      @percentage_of_time = Typecast.to_percentage(adapter_values[:percentage_of_time])
      @allowed_sans = Typecast.to_set(adapter_values[:allowed_sans])
    end

    def [](key)
      if ivar = LegitIvars[key.to_s]
        instance_variable_get(ivar)
      end
    end

    def eql?(other)
      self.class.eql?(other.class) &&
        boolean == other.boolean &&
        actors == other.actors &&
        groups == other.groups &&
        percentage_of_actors == other.percentage_of_actors &&
        percentage_of_time == other.percentage_of_time &&
        actors_count == other.actors_count &&
        allowed_sans == other.allowed_sans
    end

    alias_method :==, :eql?
  end
end
