require './config/environment'
require "./app/models/user"
require "./app/models/tweet"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do

    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session) == true
      redirect('/tweets')
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])

    if @user.username == ""
      redirect('/signup')
    elsif @user.email == ""
      redirect('/signup')
    elsif @user.save == false
      redirect('/signup')
    else
      @user.save
      Helpers.is_logged_in?(session) == true
      session[:user_id] = @user.id
      redirect('/tweets')
    end
  end

  get '/tweets' do
    @tweets = Tweet.all

    erb :'/tweets/show_tweets'
  end

end
