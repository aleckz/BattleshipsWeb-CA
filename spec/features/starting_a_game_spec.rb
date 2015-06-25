require 'spec_helper'

feature 'Starting a game' do
  
  scenario 'visiting the homepage' do
    visit '/'
    expect(page).to have_content 'Welcome to Battleships, Mothafucka!'
  end  


end