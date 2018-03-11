require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  #load homepage
  get '/' do
    # erb :index
    "Welcome to Fwitter"
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  get '/tweets' do
    erb :'/tweets/tweets'
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      redirect '/tweets'
    else
      redirect to '/signup'
    end
  end

end
