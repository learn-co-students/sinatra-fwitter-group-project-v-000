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
    erb :"/users/create_user"
  end

  post '/signup' do
    @user = User.new(username: params["username"], email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect to "/tweets"
  end

  get '/tweets' do
    erb :"tweets/tweets"
  end

  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    
  end

  private
  def self.current_user(session)
    User.find(session[:user_id])
  end

  def self.is_logged_in?(session)
    !!(session[:user_id])
  end

end
