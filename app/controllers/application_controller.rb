require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "93160167"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  get '/users/login' do
    erb :'/users/login'
  end

  post '/signup' do
    @user = User.create(params)

    redirect to "/tweets"
  end

end
