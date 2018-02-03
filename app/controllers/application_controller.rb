require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    if session[:user_id]
      redirect to "/tweets"
    else
      erb :'signup'
    end
  end

  post '/signup' do #can't have same username
    username = params[:username]
    email = params[:email]
    password = params[:password]

    if username.empty?
      flash[:message] = "*Please enter a valid username"
      redirect to '/signup'
    elsif email.empty?
      flash[:message] = "*Please enter a valid email"
      redirect to '/signup'
    elsif password.empty?
      flash[:message] = "*Please enter a valid password"
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id

      redirect to "/tweets"
    end

  end

  get '/tweets' do
   if @current_user = User.find_by_id(session[:user_id])
      erb :'tweets'
   else
     flash[:message] = "You are not logged in"
     redirect to "/login"
   end

  end

  get '/login' do
    if session[:user_id]
      redirect to "/tweets"
    else
      erb :'/login'
    end
  end

  post '/login' do
    # binding.pry
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "*Please enter a valid username and password"
      erb :'login'
    end
  end

  get '/logout' do
    session.clear
    redirect to "/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/user_show'
  end

  get '/tweets/new' do
    if @current_user = User.find_by_id(session[:user_id])
      erb :'new'
    else
      flash[:message] = "You are not logged in"
      redirect to "/login"
    end

  end

  post '/tweets' do
    @user = User.find_by(session[:user_id])

    if params[:content].empty?
      redirect to "/tweets/new"
    else
      @tweet = Tweet.create(params)
      @tweet.user = @user
      @tweet.save
    end
  end

  get '/tweets/:id' do
    if session[:user_id]
      @tweet = Tweet.find_by(params[:id])
      erb :'/show'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id]
      @tweet = Tweet.find_by(params[:id])
      erb :'/edit'
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      erb :'/show'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete

    erb :'delete'
  end

end
