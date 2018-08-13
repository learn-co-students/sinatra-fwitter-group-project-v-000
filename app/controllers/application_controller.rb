require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do #loads the homepage
    erb :'index'
  end

  get '/tweets/new' do #creates the create tweet page
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do  #post tweet
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/signup' do
    if session[:user_id] != nil
      redirect to "/tweets"
    else
    erb :'/users/create_user'
  end
end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
        user = User.create(username: params[:username], email: params[:email], password: params[:password])
        session[:user_id] = user.id
        user.save
        redirect to "/tweets"
      else
        redirect to "/signup"
    end
  end

  get '/login' do #loads login page
    erb :'/users/login'
  end

  post '/login' do #loads login page
    @user = User.find( params[:username])
    if @user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweet/#{@user.id}"
      else
        direct "/"
      end
  end


  
end
