require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'secret'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do

    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do

    if valid_signup?(params)
      user = User.create(params) #should user be an INSTANCE variable?
      session[:user_id] = user.id

      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = current_user.tweets
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
    end
    redirect "/tweets"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'users/show'

  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if !params[:content].empty?
      @tweet = current_user.tweets.create(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id/edit' do

    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end




  helpers do # A CONFIRMER: helpers methodes pour VIEW

    def valid_signup?(params)
      !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if logged_in?
        User.find(session[:user_id])
      end
    end

  end

end
