require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, "my_application_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
      erb :index
  end

  get '/signup' do
      if !!session[:id]
          redirect '/tweets'
      else
          erb :signup
      end
  end

  post '/signup' do
      @user = User.new(params)
      if !@user.save
          redirect '/signup'
      else
          session[:id] = @user.id
          @user.save
          redirect '/tweets'
      end
  end

  get '/login' do
      if !!session[:id]
          @user = User.find(session[:id])
          redirect '/tweets'
      else
          erb :login
      end
  end

  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
          session[:id] = @user.id
          redirect '/tweets'
      else
          redirect '/login'
      end
  end

  get '/logout' do
      if !!session[:id]
          session.clear
          redirect '/login'
      else
          redirect '/login'
      end
  end
end
