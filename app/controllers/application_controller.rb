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
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    @user.save
    session[:id] = @user.id

    if @user.username.empty? || @user.password.empty? || @user.email.empty?
      redirect '/signup'
    else
      redirect '/tweets'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])

    if @user != nil
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    @user = User.find_by(session[:id])
    if @user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if is_logged_in?
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
    if is_logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content].empty?
      redirect '/tweets/new'
    elsif is_logged_in?
      @tweet = Tweet.create(content: params[:content], user_id: session[:id])
      @tweet.save
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if is_logged_in?
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if is_logged_in?
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    elsif is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect '/tweets'
    end
  end

  post '/tweets/:id/delete' do
    if is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])
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


  def is_logged_in?
    session[:id] != nil
  end

  def current_user
    User.find_by(session[:id])
  end


end