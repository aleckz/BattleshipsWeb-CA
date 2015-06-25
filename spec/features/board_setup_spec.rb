feature 'Setting up the board' do

  scenario 'creating the boards for the players' do
    visit '/new_game'
    fill_in('name', with: 'Christian')
    click_button('Submit')
    click_button('Begin')
    expect(page).to have_content "
    ABCDEFGHIJ
  ------------
 1|          |1
 2|          |2
 3|          |3
 4|          |4
 5|          |5
 6|          |6
 7|          |7
 8|          |8
 9|          |9
10|          |10
  ------------
   ABCDEFGHIJ"
  end

  def place_ship
  	fill_in('coordinate', with: 'A4')
  	select('Submarine', from: 'ship')
  	select('Vertical', from: 'direction')
  	click_button('Place')
  end

  scenario 'placing ships on the board' do
  	visit '/board'
  	place_ship
  	expect(page).to have_content "4|S"
    # the reason we can JUST write "4|S" is because have_content just needs to find part of the content, not all of it - If we're placing a ship on A4 then that content WILL be there, hence the test.
	end

	scenario 'placing ship in occupied coordinate' do 
		visit '/board'
		place_ship
		place_ship
		expect(page).to have_content 'Coordinate already occupied'
	end
end