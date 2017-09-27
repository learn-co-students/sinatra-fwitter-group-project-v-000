require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "password_security"
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    # binding.pry
    if  params[:username].empty? || params[:email].empty? || params[:password].empty?
      erb :failure
    else
      user = User.create(username: params[:username], email: params[:email],
             password: params[:password])

      redirect '/tweets'      
    end

  end
end
