require 'sinatra/base'
require 'battleships'

class BattleshipsWeb < Sinatra::Base
 
# what is inbetween -get/post do end- is what the SERVER is going to do when it receives either a GET/POST request from the client, 
# which is done in the views folder

 #enable :sessions

  set :views, proc { File.join(root,'..','views') }
  
  get '/' do
    erb :index
  end

  get '/new_game' do 
    erb :new_game
  end

  post '/new_game' do
    @user = params[:name]
    if @user == nil or @user == ''
      erb :new_game
    else
      erb :creating_username
    end
  end

# we are CREATING the INSTANCES of game, board, etc in the controller because this is where you want all your Business/App Logic to be.
# VIEWS is just for RENDERING - making things visual. Don't put any serious ruby in there.
  
  get '/board' do
    $game = Game.new Player, Board
    @board = $game.own_board_view $game.player_1
    erb :board
  end

  
  post '/board' do
    # look at Ben's battleships method for placing a ship, and how he passes the arguments.
    # params = { coordinate: 'C4', ship: 'submarine', direction: 'vertically'}
    place_ship = $game.player_1.place_ship Ship.send(params[:ship]), params[:coordinate], params[:direction]
    @board = $game.own_board_view $game.player_1
    erb :board
  end
# if rspec tests ever fail with "Not Found" it means that there is a GET/POST request being sent by the client, and the CONTROLLER doesn't have the get/post method - so it doesnt know what to do"

# posting in params a hash, where name is the key, and input from the user is the value


  # start the server if ruby file executed directly
  run! if app_file == $0
end
