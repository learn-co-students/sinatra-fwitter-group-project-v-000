require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
  	erb :index
  	#have links to login/sign up?
  end

  get '/signup' do
  end

  post '/signup' do
  end

  get '/login' do
  end

  post '/login' do
  end

  get '/logout' do
  	session.clear
  end

  get '' do
  end

  get '/tweets' do

  end


  get '/tweets/:id/edit' do
  end

  post '/tweets/:id' do
  	#update to tweets/id
  end

  post '/tweets/:id/delete' do
  	#deletion of tweet 
  end


end