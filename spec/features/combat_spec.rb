feature 'Combat' do

def place_ship
    fill_in('coordinate', with: 'A1')
    select('Submarine', from: 'ship')
    select('Vertical', from: 'direction')
    click_button('Place')
  end

  scenario 'firing at opponent\'s board' do
    visit '/board'
    place_ship
    click_button('Start Game')
    #setup to combat page complete
    fill_in('coordinate', with: "A1")
    click_button('Fire!')
    expect(page).to have_content '1|-'
  end



end