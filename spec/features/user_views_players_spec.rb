require 'rails_helper'

feature 'User views players' do
    scenario 'with all atrributes' do
      players = create_list(:player, 3)

      visit root_path #Visit is a Capybara method!
      # equivalent to typing the path into the user's address bar

      #any css selector goes in first string
      #page object is scoped to what is in the 'within' block

      #as specified in create_list, you'll do this 3 times
      players.each do |player|
        within('.player', text: player.name) do
          expect(page).to have_content player.job
          expect(page).to have_content player.health
          expect(page).to have_content player.magic
        end
      end
      #Capybara method:
      #'have_content' matcher looks at only the user-visible text on the page,
      # and searches for the string we give it, within that text
  end

  scenario 'in alphabetical order' do
    create(:player, name: 'George')
    create(:player, name: 'Zach')
    create(:player, name: 'Cecil')

    visit root_path

    expect(page).to have_content(/Cecil.*George.*Zach/)
  end
end
