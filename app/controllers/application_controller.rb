require './config/environment'

class ApplicationController < Sinatra::Base

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/signup' do

    erb :'/users/create_user'
  end

  post '/signup' do
    binding.pry

    @user = User.create(params)
    if @user.save
      redirect to "/login"
    else
      redirect to "/signup"
    end
  end

  get '/login' do

  end



end
