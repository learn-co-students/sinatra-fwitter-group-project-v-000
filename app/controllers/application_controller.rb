require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "bottlerocket"
  end

  get '/' do
    erb :index
  end

<<<<<<< HEAD
  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
        @current_user = User.find_by(id: session[:user_id])
    end
=======
  get '/signup' do
    erb :signup
  end

  post '/signup' do

    invalid = 0
    params.each do |param|
      invalid = 1 if param[1] == ""
    end
    redirect '/signup' if invalid == 1

    @user = User.create(params)
    session[:user_id] = @user.id
    redirect '/tweets'
>>>>>>> 76a5b44317ee248bf824ba9f06ea7a7e0f1ec883
  end

end
