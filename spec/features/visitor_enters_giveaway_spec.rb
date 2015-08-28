require "rails_helper"

feature "Visitor enters giveaway" do
  scenario "with valid details" do
    giveaway = create(:giveaway, :open)
    visit entry_path(giveaway)
    
    fill_in 'First name', with: 'Adam'
    fill_in 'Email', with: 'adam@example.com'
    check 'Agree to rules'    
    click_button I18n.t("giveaways.entrants.forms.create")

    expect(current_path).to eq thank_you_path(giveaway)
  end

  scenario "with invalid details" do
    giveaway = create(:giveaway, :open)
    visit entry_path(giveaway)
    
    fill_in 'First name', with: ''
    fill_in 'Email', with: ''
      
    click_button I18n.t("giveaways.entrants.forms.create")

    expect(page).to have_content "can't be blank"
    expect(page).to have_content 'is invalid'
    expect(page).to have_content 'must be accepted'
  end
end
