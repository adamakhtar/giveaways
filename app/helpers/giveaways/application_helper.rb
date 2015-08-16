module Giveaways
  module ApplicationHelper
    def tab_class_for(tab, current_tab)
      "active" if tab == current_tab
    end
  end
end
