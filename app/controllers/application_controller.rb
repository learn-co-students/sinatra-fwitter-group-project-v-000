require './config/environment'
require './app/models/user'
# require 'rack-flash'

class ApplicationController < Sinatra::Base
  # use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :"index"
  end

  get '/signup' do
    if !logged_in?
      erb :"/users/create_user"
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    # binding.pry
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      redirect '/tweets'
    end
  end

  get '/tweets' do
    # binding.pry
    @tweets = Tweet.all
    erb :"/tweets/index"
  end

  # post "/login" do
  #    @user = User.find_by(username: params[:username])
  #    if @user && @user.authenticate(params[:password])
  #      session[:user_id] = @user.id
  #      redirect to '/tweets'
  #    else
  #      redirect to 'failure'
  #    end
  #  end

 helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end

    def logout!
      session.clear
    end
  end
end
