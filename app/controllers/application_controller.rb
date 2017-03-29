require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
    enable :sessions
  end

  get '/' do
    @username = username
    erb :index
  end

  #----------------LOG IN/OUT--------------

  get '/login' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
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

  #### Create user ####

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params["username"].empty? || params["email"].empty? || params["password"].empty?
      redirect to "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:id] = @user.id
      session[:username] = @user.username
      redirect to "/tweets"
    end
  end

  #### Create tweet ####

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content])
    redirect to "/tweets"
  end

  #------------------READ------------------

  #### Users ####

  get '/users/:slug' do
    @username = username
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/show_tweets'
  end

  #### Tweets ####

  get '/tweets' do
    @username = username
    @tweets = Tweet.all
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  #-----------------UPDATE-----------------

  #-----------------DELETE-----------------

  #-----------------HELPERS----------------

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end

    def username
      session[:username]
    end
  end

end
