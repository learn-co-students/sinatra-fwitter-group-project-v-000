require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if !params.any?{|k, v| v == "" || v == " " || v == nil}
      @user = User.create(params)
      session[:id] = @user.id
    else
       redirect to '/signup'
    end
      redirect to '/tweets'
  end

  get '/tweets' do
    erb :'tweets/tweets'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      session[:id] = @user.id
      session[:username] = @user.username
      session[:email] = @user.email
      session[:password] = @user.password
      redirect to '/tweets'
    end
  end

  get "/logout" do
    session.clear
   redirect to '/login'
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/tweets'
  end

  get '/tweets/new' do

    @tweet = Tweet.create(content: params[:content])
    erb :'/tweets/create_tweet'
  end



end
