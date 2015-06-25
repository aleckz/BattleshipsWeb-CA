feature 'Setting up the board' do

  scenario 'creating the boards for the players' do
    visit '/new_game'
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




end