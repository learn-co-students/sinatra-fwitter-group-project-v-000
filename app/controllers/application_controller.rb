require './config/environment'
# require 'rack-flash'
# require "./app/models/user"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    
  end
  
  get "/" do
    erb :index
  end
  

end