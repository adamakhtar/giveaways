require 'rails/generators'
module Giveaways
  module Generators
    class ViewsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../app/views/giveaways", __FILE__)
      desc "Used to copy giveaway's views to your application's views."

      def copy_views
        view_directory :confirmations
        view_directory :entrants
        view_directory :entries
        view_directory :giveaways
        view_directory :rules
        view_directory :winners
      end

      protected

      def view_directory(name)
        directory name.to_s, "app/views/giveaways/#{name}"
      end
    end
  end
end
