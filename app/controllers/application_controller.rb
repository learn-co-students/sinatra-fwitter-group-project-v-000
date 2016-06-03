require './config/environment'
require 'rack-flash' 

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    if session[:id]
      redirect to '/tweets'
    else
      erb :signup
    end
  end
  
  post '/signup' do 
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Name, email and password are required"
      redirect to '/signup'
    end
  end

  get '/tweets' do 
    @user = User.find(session[:id])
    erb :'/tweets/index'
  end

  get '/login' do 
    if session[:id]
      redirect to '/tweets'
    end
    erb :login
  end

  post '/login' do 
    if @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Invalid username or password"
      redirect to '/login'
    end
  end
end
