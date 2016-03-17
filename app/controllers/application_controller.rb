require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/' do
    if !is_logged_in
      # redirect to :'/signup'
      erb :'users/create_user', layout: false
    else
      erb :'tweets/tweets'
    end
  end

  get '/signup' do
    erb :'users/create_user', layout: false
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.id.nil?
      redirect to '/signup'
    else
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/tweets' do
    erb :'tweets/index'
  end

  get '/login' do
    erb :'users/login', layout: false
  end

  post '/login' do
    @user = User.find_by(username: params[:username]).authenticate(params[:password])
    if !@user
      redirect to '/login'
    end
    session[:user_id] = @user.id
    redirect to '/tweets'
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def is_logged_in
    current_user != nil
  end
end
