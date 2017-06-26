require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    @user = User.create(username: params["username"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect "tweets/tweets"
  end

  get '/login' do
    erb :login
  end

  get '/logout' do
    session.clear
    erb :logout
  end


end
