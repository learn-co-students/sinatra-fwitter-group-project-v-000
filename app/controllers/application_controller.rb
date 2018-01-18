require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  before '/signup' do
    redirect '/tweets' if current_user
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
		user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if user.save
      sign_in(user)
			redirect "/tweets"
		else
			redirect "/signup"
		end
  end
  
  get '/tweets' do
    erb :'tweets/tweets'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end