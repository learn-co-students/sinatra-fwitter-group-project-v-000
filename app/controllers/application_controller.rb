require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "secret"
  end

  get '/' do
    redirect to :"/tweets" if logged_in?
    erb :index
  end

  get '/users/:username' do
    @user = User.find_by(username: params[:username])
    erb :"users/show"
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
