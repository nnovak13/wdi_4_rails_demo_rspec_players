require 'rails_helper'

feature 'User creates a player' do
  background do
    visit root_path
    click_link 'Add Player'
  end
#as a user
    #when i navigate to the new character form
    # CASE SENSITIVE for Capybara
  scenario 'successfully' do
    other_player = create(:player)
    # click_link 'Add Player' #expect that this will take us to new character form
    fill_in 'Name', with: 'Mike'
    select 'Wizard', from: 'Job' #select_from 'Job', item: 'wizard'

    #for radio buttons: choose 'Wizard'
    #for checkboxes: check 'Alive'


    # and fill it out with a name, notes, etc. and submit the form
    fill_in 'Health', with: '60'
    fill_in 'Magic', with: '140'
    click_button 'Create Player'
    # click_on 'Create Player'
    # clicks regardless of wheather it's a link or a button

    # you need to keep this mark-up compatibility now, limit false-positives
    # within('name') do
    #   expect(page).to have_content 'Mike'
    # end
    # #equivalent to...

    within('.player', text: 'Mike') do
      expect(page).to have_css '.name', text: 'Mike'
      expect(page).to have_css '.job', text: 'Wizard'
      expect(page).to have_css '.health', text: '60'
      expect(page).to have_css '.magic', text: '140'
  end
  #expect(page).to have_content 'Player successfully created'
  expect(page).to have_css '.player', text: other_player.name
  #verifies we see the player


    # expect(page).to have_content 'Mike'
    # expect(page).to have_content 'Wizard'
    # expect(page).to have_content '60'
    # expect(page).to have_content '140'
  scenario 'unsuccessfully due to required fields being blank' do
    click_button 'Create Player'

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Job can't be blank"
    expect(page).to have_content "Health can't be blank"
    expect(page).to have_content "Magic can't be blank"
  end
end

# require 'rails_helper'

# feature 'User creates a player' do
#   background do
#     visit root_path
#     click_link 'Add Player'
#   end

#   scenario 'successfully' do
#     other_player = create(:player)

#     fill_in 'Name', with: 'Mike'
#     select 'Wizard', from: 'Job'
#     fill_in 'Health', with: '60'
#     fill_in 'Magic', with: '140'
#     click_button 'Create Player'

#     within('.player', text: 'Mike') do
#       expect(page).to have_css '.name', text: 'Mike'
#       expect(page).to have_css '.job', text: 'Wizard'
#       expect(page).to have_css '.health', text: '60'
#       expect(page).to have_css '.magic', text: '140'
#     end
#     # expect(page).to have_content 'Player successfully created'
#     expect(page).to have_css '.player', text: other_player.name
#   end


