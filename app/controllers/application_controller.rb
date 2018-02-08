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
      @tweets = Tweet.all
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
      erb :create_tweet, :layout => :logged_in_layout
    else
        flash[:message] = "You're not logged in!"
        redirect '/login'
    end
  end

  get '/tweets/:tweet_id' do
    if !session[:user_id].nil?
      @user = User.find_by(id: session[:user_id])
      @tweet = Tweet.find_by(id: params[:tweet_id])
      #if @tweet.user_id == @user.id
        erb :single_tweet, :layout => :logged_in_layout
    #   else
    #     redirect '/login'
    #   end
     else
       redirect '/login'
    end
  end

  get '/tweets/:tweet_id/edit' do
    if !session[:user_id].nil?
      @user = User.find_by(id: session[:user_id])
      @tweet = Tweet.find_by(id: params[:tweet_id])
      if @tweet.user_id == @user.id
        erb :edit_tweet, :layout => :logged_in_layout
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    content = params["content"]
    if !content.empty?
      @tweet.content = content
      @tweet.save
        redirect "/tweets/#{params[:id]}"
    else
        redirect "/tweets/#{params[:id]}/edit"
    end


  end

  get '/tweets/:id/delete' do
    @user = User.find_by(id: session[:user_id])
    @tweet = Tweet.find_by(id: params[:id])
    if !@tweet.nil?
      if @user.id == @tweet.user_id
        Tweet.delete(params[:id].to_i)
      end
    end
    redirect '/tweets'

  end


  post '/submit_tweet' do
    tweet = params["content"]
    user = User.find_by(id: session[:user_id])

    if tweet.empty?
      redirect '/tweets/new'
    else
      user.tweets << Tweet.create(content: tweet)
    end

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
