class User < ActiveRecord::Base
  def can_manage_giveaways?
    giveaways_admin?
  end
end
