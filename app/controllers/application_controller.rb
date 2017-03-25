require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    !logged_in? ? (erb :'users/create_user') : (redirect to '/tweets')
    #if session[:id].nil?
    #  erb :'users/create_user'
    #else
    #  redirect to '/tweets'
    #end
  end

  get '/tweets' do
    !!logged_in? ? (erb :'tweets/tweets') : (redirect to '/login')
    #binding.pry
    #if logged_in?
    #  erb :'tweets/tweets'
    #else
    ##end
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
    !logged_in? ? (erb :'users/login') : (redirect to '/tweets')
    #if session[:id].nil?
    #  erb :'users/login'
    #else
    #  redirect to '/tweets'
  #  end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if !!@user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if !!logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

end
