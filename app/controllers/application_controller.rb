require './config/environment'

class ApplicationController < Sinatra::Base

  helpers SessionHelpers

  enable :sessions
  set :session_secret, "secret"
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

#HOMEPAGE
  get '/' do
    erb :'index'
  end

# SENDS signup form
  get '/registrations/signup' do
    redirect to "/tweets" if is_logged_in?(session)
    erb :'/registrations/signup'
  end

# POSTS sign up form and CREATES user
  post '/registrations/signup' do

    if params[:username] == "" || params[:email] == "" ||  params[:password] == ""
      redirect to '/registrations/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:id] = @user.id
      redirect to '/tweets/index'
    end
  end
#SHOW LOGIN form
  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions/login' do
    @user = User.find_by(username: params["username"])
      # , password: params["password"])
  

    if @user && @user.authenticate(params["password"])

      session[:user_id] = @user.id
      redirect 'tweets/index' # or users/index
    else
      redirect to '/sessions/login' # or message about trying again.error page?
    end
  end

#CLEAR the session
  get '/sessions/logout' do
    erb :'sessions/logout'
  end

  post '/sessions/logout' do
    session.clear
    redirect to  '/'
  end

  get '/users/index' do
     #render user's homepage view
     @user = User.find(session[:id])
      erb :'/users/index'
  end
end
