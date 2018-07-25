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
    if logged_in?
      redirect '/tweets'
    else
    erb :signup
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect to '/signup'
    else
      @user = User.create(params)
      @user.save
    session[:user_id] = @user.id
    redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
    erb :login
  end
  end

  post '/login' do
    @user = User.find_by(params[:id])
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/logout' do
      session.destroy
      redirect '/login'
  end


def logged_in?
!!current_user
end

def current_user
  @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
end


end
