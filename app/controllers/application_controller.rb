require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/' do
    erb :homepage
  end

  get '/signup' do
    @is_logged_in = Helpers.is_logged_in?(session)
    if @is_logged_in != true
      erb :signup
    else
      @user = Helpers.current_user(session)
      redirect to "/tweets"
    end
  end

  post '/signup' do
    if params['username'] == "" || params['email'] == "" || params['password'] == ""
      redirect to '/signup'
    else
      @session = session
      @new_user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
      session[:user_id] = @new_user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    @is_logged_in = Helpers.is_logged_in?(session)
    if @is_logged_in != true
      erb :login
    else
      @user = Helpers.current_user(session)
      redirect to "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(username: params['username'])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    @is_logged_in = Helpers.is_logged_in?(session)
    if @is_logged_in != true
      redirect to '/login'
    else
      session.clear
      redirect to "/login"
    end
  end
end
