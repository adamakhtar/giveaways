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

  scenario "via preview" do
    admin = create(:user, :admin)
    ipad_giveaway = create(:giveaway, title: 'Ipad giveaway')

    visit giveaways.giveaways_path
    click_link ipad_giveaway.title
    click_link t('giveaways.giveaways.preview_link')

    expect(page).to have_content ipad_giveaway.title
    expect(page).to have_content ipad_giveaway.description

    click_link t('giveaways.giveaways.exit_preview_link')
  end
end
