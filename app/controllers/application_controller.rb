require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    
    # sessions
    enable :sessions unless test?
    set :session_secret, "secret"
  end
  
  get '/' do
    erb :"/index"
  end
  
  get '/signup' do
    if session[:user_id].nil?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end
  
  post '/signup' do
    if !params["username"].empty? && !params["password"].empty? && !params["email"].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end
  
  helpers do
    
    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find(session[:user_id])
    end
    
  end
  

  
end
