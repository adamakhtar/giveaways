module Giveaways
  class ApplicationController < ::ApplicationController
    
    layout Giveaways.admin_layout 

    before_action :detect_preview_mode

    def ensure_admin
  		redirect_to sign_in_path unless giveaway_user.can_manage_giveaways?
  	end

    def detect_preview_mode
      session[:preview_mode] ||= false
      session[:preview_mode] = true if params[:preview_mode] == "true"
      session[:preview_mode] = false if params[:preview_mode] == "false"
    end
  end
end
