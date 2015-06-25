require 'sinatra/base'

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

   get '/board' do
      erb :board
   end
  

# posting in params a hash, where name is the key, and input from the user is the value


  # start the server if ruby file executed directly
  run! if app_file == $0
end
