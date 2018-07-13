require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

get '/' do
  erb :index
end

# post '/login' do
#   @user = User.find_by(:username => params[:username])
#   if @user && @user.authenticate(params[:password])
#     session[:user_id] = @user.id
#     redirect '/tweets'
#   else
#     erb :error
#   end
# end

  get '/account' do
    @current_user = User.find_by_id[session[:user_id]]
    if @current_user
      erb :account
    else
      erb :error
    end
  end

  helpers do
    def current_user
    #  User.find_by(id: session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

    end

    def logged_in?
      #!!User.find_by(id: session[:user_id])
      !!current_user
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
        redirect "/login"
      else
        redirect '/'
      end
    end
  end
