require "rails_helper"

feature "Admin creates a giveaway" do
  before do
    @admin = create(:user, :admin)
  end

  scenario "with valid details" do
    visit new_giveaway_path
    
    fill_in 'Title', with: 'PSP Competition'
    fill_in 'Description', with: 'Get the latest tech for free.'
    fill_in 'Number of prizes', with: '1'
    fill_in 'Email from', with: 'Admin'
    fill_in 'Email reply to', with: 'admin@example.com'
    click_button I18n.t("giveaways.giveaways.forms.create")


    # expect(page.body).to include( I18n.t("giveaways.giveaways.created") )
    expect(current_path).to eq giveaway_path(Giveaways::Giveaway.last)
  end
end
