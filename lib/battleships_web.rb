require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base
 
  set :views, proc { File.join(root,'..','views') }
  
  get '/' do
    erb :index
  end

  get '/new_game' do 
    erb :new_game
  end

  post '/new_game' do
    @user = params[:name]
    erb :creating_username
  end





# posting in params a hash, where name is the key, and input from the user is the value




  # start the server if ruby file executed directly
  run! if app_file == $0
end
