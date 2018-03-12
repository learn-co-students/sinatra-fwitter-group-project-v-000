require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret","password_security"
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to :"/tweets"
    else
      erb :'/users/create_user'
    end
  end
  get '/login' do
    if logged_in?
      redirect to :"/tweets"
    else
      erb :"/users/login"
    end
  end
  get '/logout' do
    session.clear
    redirect "/login"
  end
  get '/tweets' do
    if !logged_in?
      redirect to "/login"
    else
      @user = User.find_by(session[:user_id])
      erb :"/tweets/tweets"
    end
  end
  get "/users/:slug" do
    # binding.pry
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  get '/tweets/new' do
    if !logged_in?
      redirect to :'/login'
    else
      erb :"/tweets/create_tweet"
    end
  end
  get '/tweets/:id' do
    if !logged_in?
      redirect to :'/login'
    else
      @tweet = Tweet.find_by(params[:id])
      erb :"/tweets/show_tweet"
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to :'/login'
    else
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/edit_tweet'
    end
  end

  post '/tweets/new' do
    @user = User.find_by(session[:user_id])
    @tweet = Tweet.create(params) if !params[:content].empty?
    @user.tweets << @tweet if @user && @tweet
    redirect to :"/tweets/#{@tweet.id}"
  end
  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to :'/signup'
    else
      @user = User.create(params)
      @user.save
      session[:user_id] = @user.id
      redirect to :"/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id if @user && @user.authenticate(params[:password])
    redirect to :"/tweets"
  end
  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    @tweet.content = params[:content] if !params[:content].empty?
    @tweet.save
    redirect to :"/tweets/#{@tweet.id}/edit"
  end
  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect '/tweets'
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
