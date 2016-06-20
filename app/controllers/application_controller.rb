require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  
  get '/' do
    erb :index
  end

  get '/signup' do
     if session[:user_id] 
      redirect "/tweets"
    else
      erb :'/users/create_user', locals: {message: "Please sign up before you sign in"}
    end
  end

  post '/signup' do 
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if session[:user_id] 
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

   get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect '/login'
    end   
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if session[:user_id]
      if params[:content].empty?
        redirect '/tweets/new'
      else
        @tweet = Tweet.new(content: params[:content], user_id: session[:user_id])
        @tweet.save
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do 
   if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else 
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
   if session[:user_id]
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id] == @tweet.user_id
      erb :'/tweets/edit_tweet'
    else
      redirect "/tweets"
    end
    else
      redirect "/login"
    end
  end

 patch '/tweets/:id' do 
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if current_user == @tweet.user && logged_in?
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
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