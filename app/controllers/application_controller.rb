require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    # set :views, 'app/views'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end 
    erb :'users/create_user'
  end

  post '/signup' do
    unless params[:username].empty? || params[:email].empty? || params[:password].empty?
      user = User.new(username: params[:username], email: params[:email], password: params[:password] )
      user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
    end
    if @user 
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/' do
    erb :index
  end

  get '/login' do 
    if logged_in?
      redirect '/tweets'
    end 
    erb :"users/login"
  end

  post '/login' do 
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect '/tweets'
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
  
  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if !params[:content].empty?
      user = current_user
      user.tweets.build(content: params[:content])
      user.save
    else
      redirect '/tweets/new'
    end
  end
  
  get '/users/:slug' do 
    @user = User.find_by(username: params[:slug])
    erb :"/users/show"
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    unless params[:content].empty?
      @tweet.update(content: params[:content])
      @tweet.save
      erb :"/tweets/show_tweet"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end

  end

  delete '/tweets/:id/delete' do 
    tweet = Tweet.find(params[:id])
    user = current_user
    if tweet.user_id == user.id 
      tweet.destroy
    end
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