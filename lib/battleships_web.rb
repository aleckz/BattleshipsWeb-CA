require 'sinatra/base'
require 'battleships'

class BattleshipsWeb < Sinatra::Base
 
 enable :sessions
# what is inbetween -get/post do end- is what the SERVER is going to do when it receives either a GET/POST request from the client, 
# which is done in the views folder

 #enable :sessions

  set :views, proc { File.join(root,'..','views') }
  
  get '/' do
    erb :index
  end

  get '/start_game' do 
    erb :start_game
  end

  post '/start_game' do
    @user = params[:name]
    if @user == nil or @user == ''
      erb :start_game
    else
      erb :creating_username
    end
  end

# we are CREATING the INSTANCES of game, board, etc in the controller because this is where you want all your Business/App Logic to be.
# VIEWS is just for RENDERING - making things visual. Don't put any serious ruby in there.
  
  get '/board' do
    # UNLESS the game has started, player is going to be player 1, and vice versa.
    # $game = Game.new PLayer, Board comes AFTER the unless because if a game already exists, you don't need to initialize another new game.
    unless $game ##
      $game = Game.new Player, Board
      session[:player] = 'Player 1'
    else
      session[:player] = 'Player 2'
    end

    if is_player_1?
      @board = $game.own_board_view $game.player_1
    elsif is_player_2? # session[:player] == 'Player 2'
      @board = $game.own_board_view $game.player_2
    end

    erb :board
  end

  post '/board' do
    # look at Ben's battleships method for placing a ship, and how he passes the arguments.
    # params = { coordinate: 'C4', ship: 'submarine', direction: 'vertically'}
  begin
    if is_player_1?
      @place_ship = $game.player_1.place_ship Ship.send(params[:ship]), params[:coordinate], params[:direction]
    elsif is_player_2? # session[:player] == 'Player 2'
      @place_ship = $game.player_2.place_ship Ship.send(params[:ship]), params[:coordinate], params[:direction]
    end
  rescue RuntimeError => @error
  end
    
    if is_player_1?
      @board = $game.own_board_view $game.player_1
    elsif is_player_2? # session[:player] == 'Player 2'
      @board = $game.own_board_view $game.player_2
    end
    erb :board
  end

  get '/combat' do
    if is_player_1?
      @board = $game.own_board_view $game.player_1
    elsif is_player_2? # session[:player] == 'Player 2'
      @board = $game.own_board_view $game.player_2
    end

    if is_player_1?
      @opponent_board = $game.opponent_board_view $game.player_1
    elsif is_player_2?
      @opponent_board = $game.opponent_board_view $game.player_2
    end
      
    erb :combat
  end

# error catching, implement "you hit / missed"

  post '/combat' do
    if is_player_1?
      @board = $game.own_board_view $game.player_1
    elsif is_player_2? # session[:player] == 'Player 2'
      @board = $game.own_board_view $game.player_2
    end    
    
    if is_player_1?
      @shoot= $game.player_1.shoot params[:coordinate].to_sym
    elsif is_player_2? # session[:player] == 'Player 2'
      @shoot= $game.player_2.shoot params[:coordinate].to_sym
    end

    # you want to display your board, then you wan to SHOOT, then you want to display your opponents board AFTER you've shot, so the shot is printed on the board - obviously.
    
    if is_player_1?
      @opponent_board = $game.opponent_board_view $game.player_1
    elsif is_player_2?
      @opponent_board = $game.opponent_board_view $game.player_2
    end

    erb :combat
  end

  # post '/fire' do
# if rspec tests ever fail with "Not Found" it means that there is a GET/POST request being sent by the client, and the CONTROLLER doesn't have the get/post method - so it doesnt know what to do"

# posting in params a hash, where name is the key, and input from the user is the value


  # start the server if ruby file executed directly
  run! if app_file == $0

  private
 
  def is_player_1? 
    session[:player] == 'Player 1'
  end

  def is_player_2?
    session[:player] == 'Player 2'
  end


end
