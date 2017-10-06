require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to "/tweets"
    end
  end
#
  post '/signup' do
  #   line 26 & 27 not crucial
  #   if logged_in?
  #     redirect to "/tweets"
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to "/signup"
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    if logged_in? #prevents logged in user from seeing login page
      redirect to "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user
    # if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/users/:slug' do
    # @user = User.find_by(:username => params[:username])
    @user = User.find_by(:slug => params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    current_user = nil
    redirect to "/login"
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    @user = User.find_by(:username => params[:username])
    if params[:content] != ""
      @tweet = current_user.tweets.create(:content => params[:content], :user_id => [:user_id])
      redirect to "/tweets"
    else
      redirect to "/tweets/new"
    end

  end

  get '/tweets/:id' do
    # @user = User.find_by(:username => params[:username])
    if logged_in?
      # binding.pry
      @tweet = Tweet.find_by_id(params[:id]) #not found by content, but specifically by id
      erb :"/tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    if logged_in? && params[:content] != ""
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user_id == session[:user_id]
      @tweet.destroy
      redirect to "/tweets"
    end
  end

#Helpers
  def current_user
    User.find_by(session[:user_id]) if session[:user_id]
    #default is nil if session[:user_id] doesn't exist
  end

  def logged_in?
    # !!session[:user_id]
    !!current_user
  end
#

end
