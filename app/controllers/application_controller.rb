require './config/environment'
require 'pry'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end


  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end


  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Missing Information- Please Try Sign Up Again"
      redirect '/signup'
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if user.save

      redirect '/tweets/tweets'
      end
    end
  end

    get '/users/login' do
      erb :'users/login'
    end

    post '/users/login' do
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets/tweets'
      else
        flash[:message] = "Login Failed, Please Try Again"
        redirect '/users/login'
      end
    end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end
  end

end
