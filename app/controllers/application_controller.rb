require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end
  
  get '/' do
    erb :index
  end
  
  get '/signup' do
    #binding.pry
    if logged_in?
      redirect "/tweets"
    else
      erb :signup
    end
  end
  
  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    #binding.pry
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user.save
      session[:user_id] = @user.id
      #binding.pry
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end
  
  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    #binding.pry
    session[:user_id] = @user.id
    redirect "/tweets"
    binding.pry
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end
  
  get '/tweets' do
    #binding.pry
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect "/login"
    end
  end
  
  get '/users/:id' do
    @user = User.find(params[:id])
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end
  
  post '/tweets' do
    if logged_in? && !params[:content].empty?
      #binding.pry
      @tweet = Tweet.create(:content => params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
    else
      redirect "/tweets/new"
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else 
      redirect "/login"
    end
  end
  
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:user_id]
      #binding.pry
      @tweet.destroy
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit'
    else
      redirect "/login"
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(:content => params[:content])
      @tweet.save
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
