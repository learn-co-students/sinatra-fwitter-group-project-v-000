require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'this_is_a_secret'
  end

  helpers do 
    def current_user
      User.find(session[:user_id])
     end
 
     def logged_in?
       !!session[:user_id]
     end
  end

  get '/' do 
    erb :'/index'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/create_user'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
    @user = User.create(params)
    session[:user_id] = @user.id 
    redirect '/tweets'
    end
  end


end