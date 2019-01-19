require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    # Can I find a way to call the helper method #logged_in? instead?
    if !!session[:user_id]
      redirect "/tweets"
    else
      erb :'signup'
    end
  end

  post '/signup' do
    # can't get this to work: user = User.new(params[:user])
    # password is showing
    user = User.new(username: params[:username], email: params[:email], password: params[:password])


    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    # Can I find a way to call the helper method #logged_in? instead?
    if !!session[:user_id]
      redirect "/tweets"
    else
      erb :'login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  

  get '/logout' do
    # Can I find a way to call the helper method #logged_in? instead?
    if !!session[:user_id]
      session.clear
      redirect "/login"
    else
      redirect "/login"
    end
  end



end

helpers do

  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

end
