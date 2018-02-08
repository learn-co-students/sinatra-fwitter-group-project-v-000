require './config/environment'
require "rack-flash"
class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"

    use Rack::Flash
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !session[:user_id].nil?
        redirect '/tweets'
    else
      erb :signup
    end

  end

  get '/tweets' do
    if !session[:user_id].nil?
      @user = User.find_by(id: session[:user_id])
      erb :user_home
    else
      flash[:message] = "You are not logged in!"
      redirect '/login'
    end
  end

  get '/login' do
    if !session[:user_id].nil?
      @user = User.find_by(id: session[:user_id])
      redirect '/tweets'
    else
      erb :login
    end
  end

  get '/logout' do
    if !session[:user_id].nil?
      username = User.find_by(id: session[:user_id]).username
      session.delete(:user_id)
      flash[:message] = "You have successfully logged out!"
    end

    redirect '/login'
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :user_home
  end

  get '/tweets/new' do

    if !session[:user_id].nil?
      @user = User.find_by(id: session[:user_id])
      erb :create_tweet
    else
        flash[:message] = "You're not logged in!"
        redirect '/login'
    end
  end

  post '/submit_tweet' do
    tweet = params["content"]
    user = User.find_by(id: session[:user_id])
    user.tweets << Tweet.create(content: tweet)
    redirect '/tweets'
  end
  post '/signup' do
    username = params["username"]
    password = params["password"]
    email = params["email"]

    created_user = User.create(username: username, password: password, email: email)
    session[:user_id] = created_user.id

    if !username.empty? && !password.empty? && !email.empty?
      redirect '/tweets'
    else
        redirect '/signup'
      end
  end

  post '/login' do
    username = params["username"]
    password = params["password"]

    found_user = User.find_by(username: username, password: password)
    session[:user_id] = found_user.id
    redirect '/tweets'
  end

end
