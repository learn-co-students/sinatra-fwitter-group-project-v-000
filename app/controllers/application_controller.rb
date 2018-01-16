require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    use RackSessionAccess if environment == :test
  end
  
  get '/' do
    erb :index
  end
  
  ##USER
  
  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect '/tweets'
    end
  end
  
  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end
  
  get '/login' do
    if logged_in?
      redirect '/tweets'
    else 
      erb :'/users/login'
    end
  end
  
  get '/logout' do
    if logged_in?
    logout!
    redirect '/login'
    else
      redirect '/'
    end
  end
  
  post '/login' do
    if params[:username] == "" || params[:password] == ""
      redirect '/login'
    else
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect '/tweets'
      else
        redirect '/login'
      end
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/index'
  end
  
  
  
  
  #helper methods
  
  helpers do 
    def logged_in?
      !!current_user
    end
    
    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end
  end

  ##TWEET
  
  get '/tweets' do 
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if logged_in? && !params[:content].empty?
      @user = current_user
      @user.tweets.create(content: params[:content])
      redirect '/users/#{@user.slug}'
    elsif logged_in? && params[:content].empty?
      redirect '/tweets/new'
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    if logged_in? && Tweet.find(params[:id]).user == current_user && !params[:content].empty?
      Tweet.find(params[:id]).update(content: params[:content])
      redirect '/users/#{current_user.slug}'
    elsif logged_in?
      redirect '/tweets/#{params[:id]}/edit'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in? && Tweet.find(params[:id]).user == current_user
        @tweet = Tweet.find(params[:id])
        erb :"tweets/edit"
    elsif logged_in? && Tweet.find(params[:id]).user != current_user
        redirect "/tweets"
    else
        redirect "/login"
    end
  end
  
  delete '/tweets/:id/delete' do
    if logged_in? && Tweet.find(params[:id]).user == current_user
        Tweet.find(params[:id]).delete
        redirect "/tweets"
    elsif logged_in?
        redirect "/tweets/#{params[:id]}"
    else
        redirect "/login"
    end
  end

    
  

end