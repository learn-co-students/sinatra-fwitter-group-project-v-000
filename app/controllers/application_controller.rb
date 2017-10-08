require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  get '/signup' do

    erb :signup
  end

  get '/tweets' do

    erb :'/tweets/index'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email],password: params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end







end
