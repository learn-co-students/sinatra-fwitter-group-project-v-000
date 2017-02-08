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
          session[:id] = user.id
          redirect to '/tweets'
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
      @current_user ||= User.find_by(id: session[:id])
    end
  end

end
