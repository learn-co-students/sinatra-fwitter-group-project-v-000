require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_awesome_fwitter_app"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :'/users/login'
  end

  get '/signup' do
    erb :signup
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
