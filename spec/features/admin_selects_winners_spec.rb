require "rails_helper"

feature "Admin selects winners" do
  scenario "via dashboard" do
    admin = create(:user, :admin)
    entrant = create(:entrant, :registered) 
    giveaway = create(:giveaway, entrants: [entrant])

    visit giveaways.giveaways_path

    click_link giveaway.title

    click_link t('giveaways.tabs.winners_link')

    click_button t('giveaways.winners.draw')

    expect(page).to have_content 'Winners'

    expect(page).to have_content entrant.email
  end
end
