require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	enable :sessions
  	set :session_secret, "Tony-b4G-a-dOoOoonUt$$$$"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/tweets' if logged_in?
  	erb :index
  end

  get '/tweets/new' do
    redirect '/signup' if !logged_in?
    @user = current_user
    erb :'/tweets/create_tweet'
  end

  get '/signup' do
  	erb :'/users/create_user'
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email] , password: params[:password])
    redirect '/signup' if params[:username].empty? || params[:email].empty?
    if user.save
      #flash message: account succesfully created
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
      #flash message: error
    end
    
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/login' do
  	erb :'/users/login'
  end

  post '/tweets/new' do
   if params[:tweet_content].empty?
    #flash message with error
    redirect '/tweets/new'
   else
    Tweet.create(content: params[:tweet_content], user: current_user)
    redirect '/tweets'
   end
  end

  post '/login' do
    redirect '/tweets' if logged_in?
    user = User.find_by(username: params[:user_name])
    if user && user.authenticate(params[:user_pass])
      session[:user_id] = user.id
      redirect '/tweets'
      #set up flash message to alert user they logged in
    else
      erb :'/users/login'
      #maybe unhide an element that alerts user they failed??
    end

  end

  get '/tweets' do
    redirect '/login' if !logged_in?
    @user = current_user
    erb :'/tweets/tweets'
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

end