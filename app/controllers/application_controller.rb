class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    redirect '/signup' unless user_credentialed?
    create_user
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    find_user && authenticate_user
    redirect '/login' unless user_exists?
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/logout' do
    session.clear if logged_in?
    redirect '/login'
  end

  helpers do
    def create_user
      @user = User.create(params)
    end

    def find_user
      @user = User.find_by(username: params[:username])
    end

    def authenticate_user
      @user.authenticate(params[:password])
    end

    def user_exists?
      !!@user
    end

    def logged_in?
      !!session[:user_id]
    end

    def user_credentialed?
      !params.any? {|k,v| v.blank?}
    end
  end

end
