require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    @user = User.new(params[:user])
    if @user.save
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/tweets' do
    @user = User.find(session[:id])
    erb :'/tweets/tweets'
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