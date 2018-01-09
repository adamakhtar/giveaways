NOTE: I never got round to using this in production but it should be ready but will require some testing on your part. 

# Giveaways

![giveaways gem](https://dl.dropboxusercontent.com/u/4298391/images_for_github_readme_files/giveaways.png)

## Overview 

Giveaways gem allows you to create giveaway contests where entrants provide you thier email address to enter. The most common reason to run such contests is for marketing purposes such as building your email list. 

To encourage entrants to spread the word of the contest - something they normally would rather avoid to increase their own chances - the gem provides them with their own referall link. For every new entrant they refer they are rewarded extra chances to win the prize. 

With this gem you can 

* run multiple contests at the same time 
* set how many winners there are in a contest
* open and close contests at specifice dates and times
* require entrants to accept your rules and confirm their email addresses
* set how many extra chances an entrant is rewarded per referall
* download all entrants as CSV
* randonly draw winners
* use default stylings or roll your own

## Getting setup

Add the gem to your gemfile

```ruby
# Gemfile
gem 'giveaways'
```

```bash
bundle install

rails g giveaways:install
```

The last command will do a number of things such as create an initializer with configuration settings; copy essential migrations and migrate your database and mount the giveaways engine at `/giveaways` in your routes file. 

You can customize the defined path to your contests by modifying the placeholder generated by the install command.

```ruby
Rails.application.routes.draw do
  # ...

  mount Giveaways::Engine, :at => "/giveaways" # you can change this

  # ...
 end
```

The installer also adds an empty `giveaways_user` method in your application controller. It a way for the gem to get hold of your app's current user. Simply provide the code in the method to return that user. If you are using devise you can simply return current_user. 

```ruby
class AplicationController 
    def giveaways_user
       current_user # or whatever method you use to return authenticated users
    end

    def giveaways_unauthorized_path
        # return the path to redirect unauthorized users.
        # e.g. root_path or sign_in_path etc
    end
end
```

The second method `giveaways_unauthorized_path` returns the path to return to whenever a user / visitor tries to access the admin without authorization. Probably sending them to your sign in page is the best bet.

## Final steps

There are a three extra things you will need to do that the installer couldn't:

**1. Define a method in your User model (or equivalant) to authorize access to the Giveaways admin dashboard**

Add a method called `can_manage_giveaways?` to your User model. Instances which return true will be able to access the admin dashboard.

```ruby
class User
    def can_manage_giveaways?
        # returns true if　authorized
        # e.g.
        # return true if admin? or moderator?
    end
end
```

**2. Add the giveaway stylesheet to your assets path**

Because the gem's layouts are loading a file called 'giveaways.css' and not 'application.css'  you will need to add 'giveaways.css' to your **assets** file path. This is to prevent any of giveaways styles bleeding into your own and vice versa. 

In config/intializers/assets.rb add or ammend the following line

```ruby
# note extension is the post compiled extension of css
Rails.application.config.assets.precompile += %w( giveaways.css ) 
```

**3. Make sure you have a mailer setup**

Everytime an entrant enters a content they will be emailed a confirmation link to confirm their email. This means you need to have a mailer setup.

You can do that by reading the [Rails guide on mailers](http://guides.rubyonrails.org/action_mailer_basics.html)

In development you might want to add ryanb's excellent [letter_opener gem](https://github.com/ryanb/letter_opener). This allows you to preview all emails in your browser as they are sent - no more checking your logs to see everything is ok.

**And that's it!**

You are all set. Simply visit /giveaways/giveaways to get started 

## Optional configuration

**Define a 'Back to app' link**

In the admin section there is a convenience link back to your app. By default it is set to '/'. You can change it by adding the following to the initializer file mentioned above

```ruby
Giveaways.main_app_path = '/welcome'
```

**Styling with custom css and html**

If you don't wan't to use the default styles or views you can roll your own. 

First you should get copies of the views by running 

```
rails g giveaways:views
```

These views will still use the default layouts inside the gem but you will want to use your own layouts. 

To provide your own layouts which you have in your usual layouts directory, specify their location in the initializer. You can define two layouts. One for the admin side and the second for all the publicly facing views such as the contest entry form. 

```ruby
# config/initializers/giveaways.rb  
Giveaways.admin_layout = 'layouts/application' # path to your application layout
Giveaways.public_layout = 'layouts/another_layout'
```

Because admin can preview contests whilst they construct them you will need to provide a link to exit the preview mode. You can simply include this partial in your public layout:

```ruby
<%= render partial: 'giveaways/shared/exit_preview' %>
```

In your admin area you can also include the default nav in your custom admin layout with this partial:


```ruby
<%= render partial: 'giveaways/shared/admin_nav' %>
```


## Problems? Ideas for improvements?

Let me know via the issue tracker!

Have fun.

Adam.
