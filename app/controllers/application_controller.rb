require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions, :dump_errors
    set :session_secret, "catalano"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end

    erb :'/users/create_user'
  end

  post '/signup' do
    if logged_in?
      redirect '/tweets'
    elsif params[:username] == "" || params[:username] == " "
      redirect '/signup'
    elsif params[:email] == "" || params[:email] == " "
      redirect '/signup'
    elsif params[:password] == "" || params[:password] == " "
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
    else
      redirect '/login'
    end

    erb :'/tweets/tweets'
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect '/login'
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
