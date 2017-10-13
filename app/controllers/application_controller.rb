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

  get '/login' do
    if !Helpers.is_logged_in?(session)
      erb :login
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/signup' do

    if !Helpers.is_logged_in?(session)

      erb :signup
    else

      redirect to '/tweets'
    end
  end

  post '/signup' do
    if (params[:password] && !params[:password].empty?) && (params[:username] && !params[:username].empty?) && (params[:email] && !params[:email].empty?)
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    session.clear
    params.clear
    redirect to '/login'
  end
end
