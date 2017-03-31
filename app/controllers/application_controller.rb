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

  #----------------SESSIONS--------------

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

  get '/signup' do ### CREATE USER
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

  get '/tweets/new' do ### CREATE TWEET
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if !params["content"].empty?
      @tweet = Tweet.create(content: params[:content], user_id: session[:id])
      redirect to "/tweets"
    else
      redirect '/tweets/new'
    end
  end

  #------------------READ------------------

  get '/users/:slug' do ### USER TWEETS
    @username = username
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/user_tweets'
  end

  get '/tweets/:id' do ### ONE TWEET
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets' do ### ALL TWEETS
    if logged_in?
      @username = username
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  #-----------------UPDATE-----------------

  get '/tweets/:id/edit' do
    if logged_in?
      @username = username
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params["content"].empty? || params["content"] != "" || params["content"] != " "
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = (params[:content])
      @tweet.save
      redirect to "/tweets"
    end
  end

  #-----------------DELETE-----------------

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.destroy
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end

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
