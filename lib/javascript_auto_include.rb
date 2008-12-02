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
      @@jsai_paths      = []
      
      def javascript_auto_include_tags
        @@jsai_paths = []
        return unless File.directory? @@jsai_path
        if File.exists?(File.join(@@jsai_path, controller.controller_path + @@jsai_ext))
          @@jsai_paths.push(File.join(@@jsai_url, controller.controller_path))
        end
        search_dir(controller.controller_path, controller.action_name)
        javascript_include_tag *@@jsai_paths
      end
      
      private
      def search_dir(cont, action)
        dir = File.join(@@jsai_path, cont)
        return unless File.directory? dir
        Dir.new(dir).each do |file|
          if File.extname(file) == @@jsai_ext
            file.split(@@jsai_delimiter).collect do |part|
              @@jsai_paths.push(File.join(@@jsai_url, cont, file)) if File.basename(part, @@jsai_ext) == action
            end
          end
        end
      end
      
    end
  end
end