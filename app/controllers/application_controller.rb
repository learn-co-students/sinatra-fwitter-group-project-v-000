require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
  end

  get '/' do
    if logged_in?
      @user = User.find(session[:id])
    end
    erb :'/index'
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/signup'
    end
  end

  post "/signup" do
    if params[:username] == '' ||  params[:email] == '' || params[:password] == ''
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/login'
    end
  end

  post "/login" do
    if logged_in?
      redirect to '/logout'
    else
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        flash[:message] = "Unable to Authenticate: Please try again"
        redirect "/login"
      end
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
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
