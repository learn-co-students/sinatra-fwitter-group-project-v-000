require './config/environment'

class ApplicationController < Sinatra::Base
  include Validate::InstanceMethods
  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?(session)
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post '/signup' do
    if !!user_params_blank?(params)
      redirect "/signup"
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      user.id = session[:session_id]
      if user.save
        redirect "/tweets"
      else
        erb :failure
      end
    end
  end

  get '/login' do
    if logged_in?(session)
      redirect "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      user.id = session[:session_id]
      user.save
      redirect "/tweets"
    else
      erb :failure
    end
  end

  get '/logout' do
    if logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    user = User.find_by_slug("#{slug}")
    redirect "/tweets/<%= user.slug %>"
  end

  helpers do
    def current_user(session)
      user = User.find_by_id(session[:session_id])
    end

    def logged_in?(session)
      !!current_user(session)
    end
  end
end
