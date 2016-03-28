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
    if session[:id]
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if empty_fields?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    @user = User.find_by(id: session[:id])
    erb :'tweets/index'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
    else
        redirect "/failure"
    end
  end

  private
  def empty_fields?
    params[:username].empty? || params[:password].empty? || params[:email].empty?
  end
end
