require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    "<h1>Welcome to Fwitter</h1><p><a href='/signup'>Sign Up</a></p><p><a href = '/login'>Log In</a></p>"
  end

  get '/signup' do
    if session[:id].nil?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  get '/tweets' do
    if !!session[:id]
      erb :index
    else
      redirect to '/login'
    end
  end

  post '/signup' do
    if !params.values.any? {|value| value.empty?}
      user = User.create(params)
      session[:id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if session[:id].nil?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(params)
    if !!@user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if !!session[:id]
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
