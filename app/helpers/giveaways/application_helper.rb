module Giveaways
  module ApplicationHelper
    def tab_class_for(tab, current_tab)
      "active" if tab == current_tab
    end

    def preview_mode_on?
      session[:preview_mode] == true
    end
  end
end
