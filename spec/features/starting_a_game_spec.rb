require 'spec_helper'

feature 'Starting a game' do
  
  scenario 'visiting the homepage' do
    visit '/'
    expect(page).to have_content 'Welcome to Battleships, Mothafucka!'
  end  

  scenario 'users click button to start game' do 
    visit '/'
    click_link('Start Game')
    expect(page).to have_content 'Identify yourself... Mothafucka'
  end
end