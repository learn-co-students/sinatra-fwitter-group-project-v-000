require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    if !session[:id]
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  get '/login' do 
    if !session[:id]
      erb :'users/login'
    else 
      redirect '/tweets'
    end
  end

  get '/tweets' do 
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  post '/login' do 
    user = User.find_by(:username => params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect to '/signup'
    end

  end

  post '/signup' do     
   
    @user = User.new(params[:user])

    if @user.save
      session[:id] = @user.id 
      redirect '/tweets'

    elsif 
      redirect '/signup'
    end
  end
   

end