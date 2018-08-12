require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
  
      if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
            user = User.create(username: params[:username], email: params[:email], password: params[:password])
            user.save
      end

    redirect to "/tweets"
  end

  get '/login' do #loads login page
    erb :'/users/login'
  end

  post '/login' do #loads login page
    user = User.find()
    redirect to
  end

end
