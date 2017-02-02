require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/tweets/new' do

  end

  get '/tweets' do
    @user = User.find(session[:id])
    erb :'tweets/tweets'
  end

  get '/tweet/:id' do

  end

  get '/tweet/:id/edit' do

  end

  patch '/tweet/:id' do

  end

  post '/tweet/:id/delete' do

  end

  get '/signup' do
    if !session[:id] == nil
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(params)
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !session[:id] == nil
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  post '/logout' do

  end
end
