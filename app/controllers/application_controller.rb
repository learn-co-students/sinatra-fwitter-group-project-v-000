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

  get '/login' do
    binding.pry

    erb :login
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    binding.pry
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/tweets'
  end

end
