require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get 'singup' do
    erb :signin
  end

  post 'signup' do

  end
end
