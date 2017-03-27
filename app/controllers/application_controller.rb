require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
    enable :sessions
  end

  get '/' do
    erb :homepage
  end

  #------------------LOGIN-----------------

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    if User.find_by(username: params[:username])
      session[:id] = User.find_by(username: params[:username], password: params[:password])
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  #-----------------CREATE-----------------

  #Create user
  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to "/"
    else
      erb :signup
    end
  end

  post '/signup' do
    if params["username"].empty? || params["email"].empty? || params["password"].empty?
      redirect to "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    end
  end

  #Create tweet
  get '/tweet' do
    erb :new
  end

  post '/tweet' do
    @tweet = Tweet.create(
    content: params[:content])
    redirect to "/tweets"
  end

  #------------------READ------------------

  get '/tweets' do
    @user = Helpers.current_user(session)
    @tweet = Tweet.all
    if Helpers.is_logged_in?(session)
      erb :tweets
    else
      redirect to "/login"
    end
  end

  #-----------------UPDATE-----------------

  #-----------------DELETE-----------------

end
