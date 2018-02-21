require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :'/index'
  end

  get '/signup' do
#  binding.pry
   if logged_in?
    redirect '/tweets' 
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    
    # binding.pry   
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
     redirect '/signup'
    else
      @user.save
      session[:user_id] = @user.id 
      redirect '/tweets'   
    end
    
  end

  get '/tweets' do
   
    erb :'/tweets/index'
  end
  # helpers do
  def logged_in?
    !!current_user
  end
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  # end
end