require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  helpers do 
    def logged_in?
      !!session[:user_id]
    end
    
    def current_user 
      User.find(session[:user_id])
    end 
  end 


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
  end
  
  
  get '/' do 
    erb :index 
  end 

end
