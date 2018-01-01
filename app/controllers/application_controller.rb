require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/:userid/tweets' do
    erb :tweets
  end

  get '/login' do
    erb :login
  end

  
end
