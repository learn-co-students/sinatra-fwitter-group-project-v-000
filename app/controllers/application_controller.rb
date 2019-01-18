require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    erb :'signup'
  end

  post '/signup' do
    # can't get this to work: user = User.new(params[:user])
    # password is showing
    user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
      binding.pry
    else
      redirect "/signup"
    end


  end

  get '/login' do
    erb :'login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    "hello world"
  end


    get '/tweets/new' do
      erb :'/tweets/new'
    end

    post '/tweets' do
      @tweet = Tweet.create(params[:tweet])
      # Need to assign user_id to tweet
      redirect "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    end


end

helpers do

  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

end
