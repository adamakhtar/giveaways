require 'rails/generators'
module Giveaways
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option "user-class", :type => :string
      class_option "no-migrate", :type => :boolean
      class_option "current-user-helper", :type => :string

      source_root File.expand_path("../install/templates", __FILE__)
      desc "Used to install Giveaways"

      def install_migrations
        puts "Copying over Giveaways migrations..."
        Dir.chdir(Rails.root) do
          `rake giveaways:install:migrations`
        end
      end


      def add_unauthorized_path_helper
        unauthorized_method = %Q{
  def giveaways_unauthorized_path
      # return the path to redirect unauthorized users.
      # e.g. root_path or sign_in_path etc
  end
  helper_method :giveaways_unauthorized_path

        }

        inject_into_file("#{Rails.root}/app/controllers/application_controller.rb",
                         unauthorized_method,
                         :after => "ActionController::Base\n")
      end


      def determine_current_user_helper
        current_user_helper = options["current-user-helper"].presence ||
                              ask("What is the current_user helper called in your app? [current_user]").presence ||
                              :current_user

        puts "Defining giveaways_user method inside ApplicationController..."

        giveaways_user_method = %Q{
  def giveaways_user
    #{current_user_helper}
  end
  helper_method :giveaways_user

}

        inject_into_file("#{Rails.root}/app/controllers/application_controller.rb",
                         giveaways_user_method,
                         :after => "ActionController::Base\n")

      end


      def add_giveaways_initializer
        path = "#{Rails.root}/config/initializers/giveaways.rb"
        if File.exists?(path)
          puts "Skipping config/initializers/giveaways.rb creation, as file already exists!"
        else
          puts "Adding giveaways initializer (config/initializers/giveaways.rb)..."
          template "initializer.rb", path
          require path 
        end
      end

      def run_migrations
        unless options["no-migrate"]
          puts "Running rake db:migrate"
          `rake db:migrate`
        end
      end

      def mount_engine
        puts "Mounting Giveaways::Engine at \"/giveaways\" in config/routes.rb..."
        insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
          %Q{
  mount Giveaways::Engine, :at => '/giveaways'
}
        end
      end

      def create_assets
        create_file Rails.root + "vendor/assets/stylesheets/giveaways.css.scss" do
          %Q{ 
@import "giveaways/base";
}
        end
      end

      def finished
        output = "\n\n" + ("*" * 53)
        output += %Q{\nDone! Giveaways has been successfully installed.

Here's what happened:\n\n}

        output += step("Giveaway's migrations were copied over into db/migrate.\n")
        output += step("A new method called `giveaways_user` was inserted into your ApplicationController.
   This lets Giveaways know what the current user of your application is.\n")

             output += step("Anoter new method called `giveaways_unauthorized_path` was inserted into your ApplicationController.
        This lets Giveaways know where to redirect users trying to access stuff they shouldn't.\n")
        output += step("A new file was created at config/initializers/forem.rb
   This is where you put Giveaway's configuration settings.\n")

        unless options["no-migrate"]
          output += step("`rake db:migrate` was run, running all the migrations against your database.\n")
        end
        output += step("The engine was mounted in your config/routes.rb file using this line:

        mount Giveaways::Engine, :at => \"/giveaways\"

If you want to change where the giveaways are located, just change the \"/giveaways\" path at the end of this line to whatever you want.\n\n˜")
        
        output +="Final Steps\n"
        output +="===========\n\n"


        output += "- Define a method to determine which users can access the Giveaways admin area.\n"
        output += %Q{ 

          class User
            def can_manage_giveaways?
              # e.g.
              # return true if ( admin? or moderator? )
            end
          end

        }

        output += "- Add the giveaways stylesheet to your assets path.\n"

        output += %Q{ 

In config/intializers/assets.rb add or ammend the following line

          # note extension is the post compiled extension of css
          Rails.application.config.assets.precompile += %w( giveaways.css ) 

        }

        output += "That's it. For optional setup see the Readme. Thanks for using Giveaways!"
        puts output
      end

      private

      def step(words)
        @step ||= 0
        @step += 1
        "#{@step}) #{words}\n"
      end

      def user_class
        @user_class
      end

      # def next_migration_number
      #   last_migration = Dir[Rails.root + "db/migrate/*.rb"].sort.last.split("/").last
      #   current_migration_number = /^(\d+)_/.match(last_migration)[1]
      #   current_migration_number.to_i + 1
      # end
    end
  end
end
