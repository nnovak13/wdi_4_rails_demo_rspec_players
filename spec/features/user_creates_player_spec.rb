require 'spec_helper'

feature 'User creates player' do
  scenario 'successfully' do
    visit root_path

    click_link 'New Player'
    fill_in 'Name', with: 'Mike'
    select 'Wizard', from: 'Job'
    fill_in 'Health', with: '70'
    fill_in 'Magic', with: '140'
    click_button 'Create Player'

    expect(page).to have_content 'Player successfully created'
    expect(page).to have_content 'Mike'
    expect(page).to have_content 'Wizard'
    expect(page).to have_content '70'
    expect(page).to have_content '140'
  end
end
