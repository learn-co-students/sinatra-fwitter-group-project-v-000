require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
      set :session_secret, "supercalifragilisticexpialidoshis"
  end

  get '/' do
    erb :index
  end

  helpers do

    def current_user
      @user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def current_tweet
      @tweet ||= current_user.tweets.find_by_id(params[:id])
    end

    def logged_in?
      !!current_user
    end

    def login(username, password)
      @user = User.find_by(username: username)
      if @user && @user.authenticate(password)
        session[:user_id] = @user.id
        redirect to '/tweets'
      elsif @user && !@user.authenticate(params[:password])
        @wrong_password = true
        erb :'/users/login'
      else
        @wrong_email = true
        erb :'/users/login'
      end
    end

    def logout!
      session.clear
      redirect to '/'
    end

  end

end
