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
    !!current_user
    # @user = User.all params[:user_id]
      end
  end


  def current_user
    
  end
# Check return values in def current_user

# Code Below from Sinatra Lesson:
  #   if session[:user_id] == 1
  #     # "Session ID set. It's currently set to #{session[:user_id]}."
  #     redirect '/fetch_session_id'
  #   else
  #     "Session ID has not been set!"
  #   end
  # end


end
