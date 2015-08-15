require "rails_helper"

feature "Admin views giveaways" do
  scenario "via dashboard" do
    admin = create(:user, :admin)
    ipad_giveaway = create(:giveaway, title: 'Ipad giveaway')
    xbox_giveaway = create(:giveaway, title: 'Xbox giveaway')
    visit giveaways.giveaways_path

    expect(page).to have_content ipad_giveaway.title
    expect(page).to have_content xbox_giveaway.title

    click_link ipad_giveaway.title

    expect(current_path).to eq giveaway_path(ipad_giveaway)
    expect(page).to have_content(ipad_giveaway.title)
  end
end
