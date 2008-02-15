module ActionView
  module Helpers
    module AssetTagHelper
      def javascript_auto_include_tags
        js_path = "#{RAILS_ROOT}/public/javascripts/views"
        if File.directory? js_path
          paths = [controller.controller_name, File.join(controller.controller_name, controller.action_name)]
          paths.collect { |source| javascript_include_tag("views/#{source}") if File.exist?(File.join(js_path, "#{source}.js")) }.join("\n")
        end
      end
    end
  end
end