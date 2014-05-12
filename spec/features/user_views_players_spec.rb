require 'spec_helper'

feature 'User views players' do
  scenario 'on the front page' do
    players = create_list(:player, 3)

    visit root_path

    players.each do |player|
      within('tr', text: player.name) do
        expect(page).to have_content player.job
        expect(page).to have_content player.health
        expect(page).to have_content player.magic
      end
    end
  end
end
