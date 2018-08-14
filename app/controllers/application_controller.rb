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
    if !logged_in?(session)
      erb :signup
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    @user = User.new(params)

    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if !logged_in?(session)
      erb :login
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get "/logout" do
    if logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    @user = User.find_by_id(session[:user_id])

    if @user
      erb :tweets
    else
      redirect "/login"
    end
  end

  helpers do
    def logged_in?(session)
      !!session[:user_id]
    end

    def current_user(session)
      User.find(session[:user_id])
    end

    def self.slug(user)
    end 
  end
end
