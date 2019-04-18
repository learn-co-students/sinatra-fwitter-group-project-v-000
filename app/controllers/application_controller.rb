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
    erb :'users/create_user'
  end


  helpers do
  def logged_in?
    !!current_user
      end
  end

  def current_user
    @user = User.find_by_id(session[:user_id])
  end

end
