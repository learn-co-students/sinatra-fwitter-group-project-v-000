require './config/environment'

class ApplicationController < Sinatra::Base
  
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    erb :index
  end
  
  get '/login' do
    if logged_in?
      redirect to "/tweets/index"
    else erb :"/users/login"
    end
  end
  
  post '/login' do
    @user = User.find_by(username: params["username"])
    session[:id] = @user.id
    redirect to :"/tweets"
  end
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect to :"/login"
    else redirect to :"/login"
    end
  end
  
  helpers do
		def logged_in?
			!!session[:id]
		end

		def current_user
			User.find(session[:id])
		end
	end

end
