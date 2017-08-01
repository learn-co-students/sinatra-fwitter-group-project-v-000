require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "fwitter_secret"
    
  end

  enable :method_override
  enable :sessions

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:id] == nil
      erb :'users/create_user'
    else
      @user = User.find(session[:id])
      redirect to "/tweets"
    end
  end 

  post '/signup' do
    @user = User.new(params)

    if @user.username == "" || @user.email == "" || @user.password == ""
      redirect to "/signup"
    elsif @user.save
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end 

  get '/tweets' do
    if session[:id] == nil
      redirect to "/login"
    else
      @user = User.find(session[:id])
      #erb :'tweets/tweets'
    end
      erb :'tweets/tweets'
  end

  get '/login' do
    if session[:id] == nil
      erb :'users/login'
    else
      @user = User.find(session[:id])
      redirect to "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect to "/login"
  end

  get '/users/#{user.slug}' do
    erb :'users/show'
  end

end