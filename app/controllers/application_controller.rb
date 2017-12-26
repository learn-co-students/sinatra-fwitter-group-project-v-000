require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :index
    end
  end

  # true || false #=> true
  # false || true #=> true
  # false || false #=> false

  post "/signup" do

    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get "/login" do
    if logged_in?
      redirect 'tweets/tweets'
    else
      erb :'users/login'
    end
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end


  end
end
