require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "wubbawubba"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    

  end

end
