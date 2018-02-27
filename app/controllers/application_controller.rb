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
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    @tweets = Tweet.all
    @user = User.find_by(:id => session[:user_id])

    if !logged_in?
      redirect '/login'
    else
      erb :"/tweets/index"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"users/login"
    end
  end

  post "/login" do
     @user = User.find_by(username: params[:username])
     session[:user_id] = @user.id
     if @user && @user.authenticate(params[:password])
       redirect '/tweets'
     else
       redirect '/login'
     end
   end

   get '/logout' do
     if !logged_in?
       redirect '/'
     else
       logout!
       redirect '/login'
     end
   end

   # get "/users/#{user.slug}" do
   #   @user = User.find_by(:id => session[:user_id])
   #   erb "/users/show"
   # end

 helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logout!
      session.clear
    end

    def slug
      self.username.gsub(" ", "-").downcase
    end

    def self.find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug}
    end
  end
end
