require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :sessions, 'fwitter'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
    erb :'users/new'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params["username"] != "" && params["email"] != "" && params["password"] != ""
    @user = User.create(username: params['username'], email: params['email'], password: params['password'])
    session[:user_id] = @user.id
    redirect to '/tweets'
    else
    redirect '/signup'
    end
  end

  get '/login' do
    if !logged_in?
    erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect 'login'
    end
  end

  helpers do
    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!current_user
    end

  end

end
