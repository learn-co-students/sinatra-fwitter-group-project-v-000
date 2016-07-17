require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sercet"
  end

  get '/' do
    erb :home
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
  user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
   else
      redirect "/login"
   end
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], password: params[:password], email: params[:email])
    if @user.save
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/tweets/new' do
    erb :new
  end

  post '/tweets' do
    redirect to :'/tweets'
  end

  get '/tweets' do
    erb :show
  end

end
