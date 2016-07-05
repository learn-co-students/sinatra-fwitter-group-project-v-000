require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Error: Please fill in all the fields."
      redirect to '/signup'
    end
  end

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      flash[:message] = "It looks like you don't have an account yet. Sign up now to get started."
      redirect to '/signup'
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect to '/login'
    else
      session.clear
      redirect to '/'
    end
  end

  get '/users/:slug' do
    erb :'/tweets/show_tweet'
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    user = User.find_by(session[:user_id])
    tweet = Tweet.new(content: params[:content])
    if tweet.save
      user.tweets << tweet
      redirect to "/tweets/#{tweet.id}"
    else
      flash[:message] = "At least say 'hello!' An empty tweet is pretty boring. :)"
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
  end


  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end