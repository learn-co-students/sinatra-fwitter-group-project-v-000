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
  	erb :create_users
  end

  post '/signup' do

  	
  	redirect '/tweets'
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
end