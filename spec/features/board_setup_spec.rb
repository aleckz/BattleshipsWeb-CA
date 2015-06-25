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

  scenario 'placing ships on the board' do
  	visit '/board'
  	fill_in('coordinate', with: 'A4')
  	fill_in('ship', with: 'submarine')
  	fill_in('direction', with: 'vertically')
  	click_button('Place')
  	expect(page).to have_content "4|S"
	end

end