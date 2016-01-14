require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "  password_security"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do
    #binding.pry
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do 
    if params.values.include?("")
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect '/tweets'
    end 
  end

  get '/login' do
    if is_logged_in?   
      redirect to '/tweets'
    else
       erb :'users/login'
    end
  end

  get '/tweets' do 
    @tweets = Tweet.all
    if is_logged_in?
      @user = User.find_by(session[:id])
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/login' do 
    if params[:username] == nil || params[:password == nil]
      redirect "/login"
    else 
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id 
        redirect "/tweets"
      else 
        redirect "/login"
      end
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
    end
    redirect '/login'
  end
 
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user.is_logged_in?
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do 
    if is_logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do 
    if params["content"] != ""
      @tweet = Tweet.create(:content => params["content"])
      @tweet.user = User.find_by(session[:id])
      @tweet.save
      redirect to '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end













  helpers do
  	def is_logged_in?
  		!!session[:id]
  	end

  	def current_user
  		User.find(session[:id])
  	end
  end
  
end