require 'flipper/ui/configuration/option'

module Flipper
  module UI
    class Configuration
      attr_reader :actors,
                  :delete,
                  :groups,
                  :percentage_of_actors,
                  :percentage_of_time,
                  :allowed_sans

      attr_accessor :banner_text,
                    :banner_class

      # Public: If you set this, the UI will always have a first breadcrumb that
      # says "App" which points to this href. The href can be a path (ie: "/")
      # or full url ("https://app.example.com/").
      attr_accessor :application_breadcrumb_href

      # Public: Is feature creation allowed from the UI? Defaults to true. If
      # set to false, users of the UI cannot create features. All feature
      # creation will need to be done through the configured flipper instance.
      attr_accessor :feature_creation_enabled

      # Public: Is feature deletion allowed from the UI? Defaults to true. If
      # set to false, users won't be able to delete features from the UI.
      attr_accessor :feature_removal_enabled

      VALID_BANNER_CLASS_VALUES = %w(
        danger
        dark
        info
        light
        primary
        secondary
        success
        warning
      ).freeze

      def initialize
        @actors = Option.new("Actors", "Enable actors using the form above.")
        @groups = Option.new("Groups", "Enable groups using the form above.")
        @allowed_sans = Option.new("Allowed SANs", "Allow only users with the given SANs to change a feature.")
        @percentage_of_actors = Option.new("Percentage of Actors", "Percentage of actors functions independently of percentage of time. If you enable 50% of Actors and 25% of Time then the feature will always be enabled for 50% of users and occasionally enabled 25% of the time for everyone.") # rubocop:disable Metrics/LineLength
        @percentage_of_time = Option.new("Percentage of Time", "Percentage of actors functions independently of percentage of time. If you enable 50% of Actors and 25% of Time then the feature will always be enabled for 50% of users and occasionally enabled 25% of the time for everyone.") # rubocop:disable Metrics/LineLength
        @delete = Option.new("Danger Zone", "Deleting a feature removes it from the list of features and disables it for everyone.") # rubocop:disable Metrics/LineLength
        @banner_text = nil
        @banner_class = 'danger'
        @feature_creation_enabled = true
        @feature_removal_enabled = true
      end

      def banner_class=(value)
        unless VALID_BANNER_CLASS_VALUES.include?(value)
          raise InvalidConfigurationValue, "The banner_class provided '#{value}' is " \
            "not one of: #{VALID_BANNER_CLASS_VALUES.join(', ')}"
        end
        @banner_class = value
      end
    end
  end
end
