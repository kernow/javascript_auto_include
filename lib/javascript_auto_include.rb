module ActionView
  module Helpers
    module AssetTagHelper
      # Checks for the existence of view related javaScripts and
      # includes them based on current controller and action name.
      # 
      # Supports the following include options
      #   Given: controller_name => "users", action_name => "new"
      # 
      # The following files will be checked for
      #   1. public/javascripts/views/users.js
      #   2. public/javascripts/views/users/new.js
      #   3. public/javascripts/views/users/new-*.js
      #   4. public/javascripts/views/users/*-new.js
      #   5. public/javascripts/views/users/*-new-*.js
      # 
      # This allows javascript files to be shared between multiple views
      # an unlimited number of views can be stringed together e.g.
      # new-edit-index.js would be included in the new, edit, and index views
      
      @@jsai_path       = "#{RAILS_ROOT}/public/javascripts/views"
      @@jsai_ext        = '.js'
      @@jsai_url        = 'views'
      @@jsai_delimiter  = '-'
      
      def javascript_auto_include_tags
        return unless File.directory? @@jsai_path
        paths = []
        if File.exists?(File.join(@@jsai_path, controller.controller_name + @@jsai_ext))
          paths.push(File.join(@@jsai_url, controller.controller_name))
        end
        paths.push(search_dir(controller.controller_name, controller.action_name))
        javascript_include_tag paths
      end
      
      private
      def search_dir(controller, action)
        dir = File.join(@@jsai_path, controller)
        return unless File.directory? dir
        paths = []
        Dir.new(dir).each do |file|
          if File.extname(file) == @@jsai_ext
            file.split(@@jsai_delimiter).collect do |part|
              paths.push(File.join(@@jsai_url, controller, file)) if File.basename(part, @@jsai_ext) == action
            end
          end
        end
        return paths
      end
      
    end
  end
end