require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do

    if session[:id]
      redirect to '/tweets'
    end
    erb :'/signup'
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])

     if @user.save
       session[:id] = @user.id
       redirect to '/tweets'
     else
         redirect to '/signup'
     end

  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end


  get '/tweets' do  #loads home page after user is in
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect to '/login'
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end
    def current_user
      @current_user ||= User.find(session[:id])
    end
  end


  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content], user: current_user)
    if tweet.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end


  get '/users/:slug' do
    erb :'show'
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user == current_user
      @tweet.delete
    end
    redirect to '/tweets'
  end


end
