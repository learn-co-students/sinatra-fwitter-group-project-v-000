require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  #load homepage
  get '/' do
    # erb :index
    "Welcome to Fwitter"
  end

  get '/signup' do
    #binding.pry
    if session.include?(:user_id)
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/tweets' do
    @user = User.find_by_id(session[:user_id])
    #@tweets = User.tweets
    erb :'/tweets/tweets'
  end

  get '/login' do
    if session.include?(:user_id)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password_digest: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect to '/signup'
      end
    end
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

end
