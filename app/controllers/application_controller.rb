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
    # @user = User.all params[:user_id =>]
    # Write code so that User is acknowledge via session
    # see Session lab
  end


  def current_user
      User.find_by_id(session[:user_id])
    end
  end

end
