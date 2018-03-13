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
    if logged_in?
      redirect '/tweets'
    end
    erb :signup
  end


  post '/signup' do

    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Missing Information- Please Try Sign Up Again"
      redirect '/signup'
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
        user.save
        session[:user_id] = user.id
        redirect '/tweets'
    end
  end

    get '/users/login' do
      if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
      end
    end

    post '/users/login' do
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets'
      else
        flash[:message] = "Login Failed, Please Try Again"
        redirect '/users/login'

      end
    end


    get '/tweets' do

      erb :'tweets/tweets'
    end


    post '/logout' do
      if logged_in?
      session.destroy
      redirect '/users/login'
    else
      redirect '/'
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
