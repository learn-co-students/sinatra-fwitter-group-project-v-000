require './config/environment'

class ApplicationController < Sinatra::Base

  register Sinatra::Flash

  configure do
    enable :sessions
    set :session_secret, 'shwitter'
    set :public_folder, 'public'
    set :views, 'app/views'
    set :show_exceptions, :after_handler
  end

  get '/' do
    redirect '/tweets' if logged_in?
    erb :'index'
  end

  get '/error' do
    erb :'error'
  end


  helpers do

    def valid_signup?(params)
      # user = User.find_by_username(params[:username])
      (!params[:username].empty? && !params[:email].empty? && !params[:password].empty?) #&& !user
    end

    def invalid_signup_routing(params)
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
        signup_missing_info
      elsif User.find_by_username(params[:username])
        signup_username_already_exists
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def login(params)
      user = User.find_by_username(params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
      elsif user && !user.authenticate(params[:password])
        wrong_password
      else
        user_does_not_exist
      end
    end

    def logout
      session.clear
      redirect'/login'
    end

    def deslug(slug)
      slug.split("-").join(" ")
    end

    def valid_tweet?(params)
      !params[:content].empty?
    end

    # errors
    def signup_missing_info
      flash[:alert] = "You need a username, email and password to sign up!"
      redirect '/signup'
    end

    def signup_username_already_exists
      flash[:alert] = "Sorry, that username already exists!"
      redirect '/signup'
    end

    def wrong_password
      flash[:alert] = "Sorry, that seems to be the wrong password!"
      redirect '/login'
    end

    def user_does_not_exist
      flash[:alert] = "Sorry, we can't find that username, please sign up!"
      redirect '/signup'
    end

    def not_logged_in
      flash[:alert] = "You're not logged in!"
      redirect '/login'
    end

    def not_your_tweet
      flash[:alert] = "Sorry, that's not yours to edit!"
      redirect '/tweets'
    end

    def invalid_tweet_new
      flash[:alert] = "Your Fweet must have some content!"
      redirect '/tweets/new'
    end

    def invalid_tweet_edit(params)
      flash[:alert] = "Your Fweet must have some content!"
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

end
