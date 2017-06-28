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
    erb :"/users/create_user"
  end

  post '/users' do
    redirect("/tweets")
  end

  get '/login' do
    erb :"/users/login"
  end

  get '/tweets' do
    erb :"/tweets/tweets"
  end

  get '/logout' do
    session.clear
    redirect("/")
  end
end
