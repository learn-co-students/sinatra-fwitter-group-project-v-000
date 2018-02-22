require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "fW1tT3r"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

    erb :'index'
  end

  get '/signup' do

  end

  get '/login' do

  end

end
