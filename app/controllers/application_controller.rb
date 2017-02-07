require './config/environment'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sdfkkboermfk;smvdofm;sfk'msl/f"
  end

  get '/' do
    erb :index
  end

  helpers do
    def login
      user = User.find_by(username: params[:username])
      if user
        if user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to '/'
        else
          flash[:login_errors] = "Wrong Password!"
        end
      else
        flash[:login_errors] = "This User does not exist!"
      end
      redirect to '/login'
    end

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

end
