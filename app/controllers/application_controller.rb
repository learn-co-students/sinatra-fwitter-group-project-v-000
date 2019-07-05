require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secretthatnooneknows"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id].nil?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
    
  end

  post '/signup' do
    # binding.pry
    if params[:username] === "" || params[:email] === "" || params[:password] === ""
      redirect to "/signup"
    end

    user = User.create(params)
    session[:user_id] = user.id
    redirect to "/tweets/"
  end

  get '/login' do
    erb :'/users/login'
  end


  post '/login' do
    # binding.pry
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end


end
