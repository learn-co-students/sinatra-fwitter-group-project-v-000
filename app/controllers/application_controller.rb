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

  get '/signup' do
  	erb :'/users/create_user'
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email] , password: params[:password])
    if user.save
      #flash message: account succesfully created
      redirect '/login'
    else
      redirect '/signup'
      #flash message: error
    end
    
  end

  get '/login' do
  	erb :'/users/login'
  end

  post '/login' do
    redirect '/tweets' if logged_in?
    binding.pry
    user = User.find_by(username: params[:user_name])
    if user && user.authenticate(params[:user_pass])
      session[:current_user] = user.id
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
    !!session[:current_user]
  end

  def current_user
    User.find(session[:current_user])
  end

end