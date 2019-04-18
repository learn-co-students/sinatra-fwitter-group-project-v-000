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


  helpers do
  def logged_in?
    # binding.pry
    current_user
    # @user = User.all params[:user_id =>]
    # Write code so that User is acknowledge via session
    # see Session lab
      end
  end

  def current_user
      @session[:user_id]
      User.find_by_id(session[:user_id])
  end
# Check return values in def current_user

  #   if session[:user_id] == 1
  #     # "Session ID set. It's currently set to #{session[:user_id]}."
  #     redirect '/fetch_session_id'
  #   else
  #     "Session ID has not been set!"
  #   end
  # end


end
