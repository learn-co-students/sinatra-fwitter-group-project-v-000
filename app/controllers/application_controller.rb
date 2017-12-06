require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.new(params)

    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    end
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do

    @tweet = Tweet.create(params)
    @tweet.user = current_user
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
    else
        redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get 'users/:username' do
    @user = User.find_by(:username => params[:username])
    if logged_in?
      @user.tweets << Tweet.find_by_id(sessions[:user_id])
      erb :'users/show'
    else
      redirect to '/login'
    end
  end


  helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        User.find(session[:user_id])
      end
    end
end
