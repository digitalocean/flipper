require 'flipper/ui/action'
require 'flipper/ui/decorators/feature'

module Flipper
  module UI
    module Actions
      class Feature < UI::Action
        include FeatureNameFromRoute

        PER_PAGE = 10

        route %r{\A/features/(?<feature_name>.*)\Z}

        def get
          @feature = Decorators::Feature.new(flipper[feature_name])
          @page_title = "#{@feature.key} // Features"
          @percentages = [0, 1, 5, 10, 15, 25, 50, 75, 100]

          @page = (@request.params["page"] || 1).to_i
          @per_page = PER_PAGE
          @actors_count = @feature.actors_count(page: @page, per_page: @per_page)

          @pages = []

          if @page > 1
            @pages << %Q|<a href="#{script_name}/features/#{@feature.key}?page=#{@page - 1}">Previous</a>|
          end

          if (@page * PER_PAGE) < @actors_count
            @pages << %Q|<a href="#{script_name}/features/#{@feature.key}?page=#{@page + 1}">Next</a>|
          end

          @pages << "#{@actors_count} actors are enabled."

          breadcrumb 'Home', '/'
          breadcrumb 'Features', '/features'
          breadcrumb @feature.key

          view_response :feature
        end

        def delete
          unless Flipper::UI.configuration.feature_removal_enabled
            status 403

            breadcrumb 'Home', '/'
            breadcrumb 'Features', '/features'

            halt view_response(:feature_removal_disabled)
          end

          feature = flipper[feature_name]
          feature.remove
          redirect_to '/features'
        end
      end
    end
  end
end
