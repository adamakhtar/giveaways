module Giveaways
  class ApplicationController < ::ApplicationController
  	def ensure_admin
  		redirect_to sign_in_path unless giveaway_user.can_manage_giveaways?
  	end
  end
end
