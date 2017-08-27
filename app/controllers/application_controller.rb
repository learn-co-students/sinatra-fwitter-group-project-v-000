require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  include Concerns::HelperMethods

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, "NachoMamma237!"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if is_logged_in?(session)
      redirect to "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      if is_logged_in?(session)
        redirect to "/tweets"
      else
        flash[:message] = "Invalid signup parameters"
        redirect to "/signup"
      end
    end
  end

  get '/login' do
    if is_logged_in?(session)
      redirect to "/tweets"
    end
    flash[:message] = "Please Log In"
    erb :"/users/login"
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      flash[:message] = "Invalid username or password"
      erb :"/users/login"
    end
  end

  get '/logout' do
    if is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
