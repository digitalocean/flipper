require 'flipper/ui/action'
require 'flipper/ui/decorators/feature'
require 'flipper/ui/util'

module Flipper
  module UI
    module Actions
      class AllowedSansGate < UI::Action
        include FeatureNameFromRoute

        route %r{\A/features/(?<feature_name>.*)/allowed_sans/?\Z}

        def get
          feature = flipper[feature_name]
          @feature = Decorators::Feature.new(feature)

          breadcrumb 'Home', '/'
          breadcrumb 'Features', '/features'
          breadcrumb @feature.key, "/features/#{@feature.key}"
          breadcrumb 'Add Allowed SAN'

          view_response :add_san
        end

        def post
          feature = flipper[feature_name]
          value = params['value'].to_s.strip

          if Util.blank?(value)
            error = Rack::Utils.escape("#{value.inspect} is not a valid domain SAN value.")
            redirect_to("/features/#{feature.key}/allowed_sans?error=#{error}")
          end

          san = Flipper::AllowedSan.new(value)

          case params['operation']
          when 'enable'
            feature.enable_san san
          when 'disable'
            feature.disable_san san
          end

          redirect_to("/features/#{feature.key}")
        end
      end
    end
  end
end
