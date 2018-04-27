require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'/users/create_user'
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to "/tweets"
      else
        redirect to "/login"
      end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect to "/login"
      else
        redirect to "/"
      end
    end

    get '/tweets' do
      if logged_in?
        erb :'/tweets/tweets'
      else
        redirect to "/login"
      end
    end

    get 'users/#{user.slug}' do
      @user = current_user
      erb :'users/show'
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
