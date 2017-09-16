require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do 
    if logged_in?
      redirect to '/tweets'
    else 
      erb :index
    end 
  end 

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else 
      redirect '/login'
    end 
  end 

  get '/tweets/new' do 
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/create_tweet'
    else 
      redirect '/login'
    end 
  end 

  get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else 
      redirect '/login'
    end
  end 

  post '/tweets' do 
    if logged_in?
      @user = User.find(session[:user_id])
      if @user == current_user
        if !params[:content].empty?
          @user.tweets << Tweet.create(content: params[:content])
          redirect '/tweets'
        else 
          redirect '/tweets/new'
        end 
      end 
    else 
      redirect '/'
    end 
  end 

  delete '/tweets/:id/delete' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user.id == current_user[:id]
        @tweet.delete 
        redirect '/tweets'
      end
    else 
      redirect '/login'
    end 
  end 
    
  get '/tweets/:id/edit' do 
    if logged_in? 
      @tweet = Tweet.find(params[:id])
      if @tweet.user.id == current_user[:id]
        erb :'tweets/edit_tweet'
      end
    else 
      redirect '/login'
    end 
  end 

  patch '/tweets/:id' do 
    if logged_in? 
      @tweet = Tweet.find(params[:id])
      if @tweet.user.id == current_user[:id] && !params[:content].empty?
        @tweet.update(content: params[:content])
        redirect "/tweets/#{@tweet.id}"
      else 
        redirect "/tweets/#{@tweet.id}/edit"
      end 
    else 
      redirect '/login'
    end 
  end 
    
  
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'tweets/tweets'
  end 

  get '/login' do 
    if logged_in?
      redirect to '/tweets'
    else 
      erb :'users/login'
    end 
  end 

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else 
      redirect to '/'
    end 
  end 

  get '/signup' do 
    if logged_in?
      redirect to '/tweets'
    else 
      erb :'users/create_user'
    end 
  end 

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if @user.save 
      session[:user_id] = @user.id 
      redirect to '/tweets'
    else 
      redirect to '/signup'
    end 
  end 

  get '/logout' do 
    if logged_in?
      session.clear 
      redirect '/login'
    else 
      redirect '/login'
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