require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'secret'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do

    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do

    if valid_signup?(params)
      user = User.create(params) #should user be an INSTANCE variable?
      session[:user_id] = user.id

      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    "display tweets"
  end

  get '/login' do
    erb :'users/login'

  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
    end
    redirect "/users/#{@user.id}" # OR SESSION[:USER_ID]??
  end

  get '/users/:id' do
    @user = User.find(params[:id]) # OR SESSION[:USER_ID]??
    erb :'/users/show'
  end

  helpers do

    def valid_signup?(params)
      !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
    end

  end

end
