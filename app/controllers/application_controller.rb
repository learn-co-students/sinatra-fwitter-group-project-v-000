require './config/environment'
require 'pry'

# => {"username"=>"skittles123",
#  "email"=>"skittles@aol.com",
#  "password"=>"rainbows"}

# => #<User:0x007faae80b9038
#  id: 1,
#  username: "skittles123",
#  email: "skittles@aol.com",
#  password: "rainbows">

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "alexander_hamilton"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    end
  end


  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by(username: params[:username])
    @tweets = Tweet.all
    erb :'users/show_user'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      @tweet = current_user.tweets.build(:content => params[:content])
      if !@tweet.content.empty?
        @tweet.save
        redirect '/tweets'
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    elsif logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect '/tweets'
    end
  end

  post '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      @tweet.delete if session[:id] == @tweet.user_id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

end