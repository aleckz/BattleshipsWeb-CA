require 'spec_helper'

# VIEWS FOLDER IS RESPONSIBLE FOR WHAT USERS SEE ON THE WEBPAGE.

feature 'Starting a game' do
  
  scenario 'visiting the homepage' do
    visit '/'
    expect(page).to have_content 'Welcome to Battleships, Mothafucka!'
  end  

  scenario 'user clicks button to start game' do 
    visit '/'
    click_link('Start Game')
    # expect(page) is referring to the next page after clicking 'Start Game'
    expect(page).to have_content 'Identify yourself...'
    # doesn't need to have EXACT content of page, just a part of the content that will be on the page.
  end

  scenario 'user enters name into a text box and clicks submit' do
    visit '/new_game'
    fill_in('name', with: 'Steve')
     #'name' here refers to the value you give to name.
    click_button('Submit')
    expect(page).to have_content "Steve"
    # to actually have content "Steve" on the next page we have to have a POST request
    # which we create using a form, and method in a new views file.
  end


  
end