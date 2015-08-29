require "rails_helper"

feature "Visitor enters giveaway" do
  scenario "with valid details" do
    giveaway = create(:giveaway, :open)
    visit entry_path(giveaway)
    
    fill_in 'First name', with: 'Adam'
    fill_in 'Email', with: 'adam@example.com'
    check 'Agree to rules'    
    click_button I18n.t("giveaways.entrants.forms.create")

    expect(page).to have_content giveaway.thank_you_message

    entrant = Giveaways::Entrant.last

    visit confirmation_path(entrant.confirmation_token)

    expect(page).to have_content t('giveaways.confirmations.completed_notice')
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
