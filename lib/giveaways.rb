require "giveaways/engine"

require "email_validator"
require "kaminari"
require "simple_form"

module Giveaways
  mattr_accessor :admin_layout, :public_layout, :main_app_path

  class << self
    def admin_layout
      @@admin_layout ||= 'giveaways/admin_default'
    end

    def public_layout
      @@public_layout ||= 'giveaways/public_default'
    end

    def main_app_path
      @@main_app_path ||= '/'
    end
  end
end
