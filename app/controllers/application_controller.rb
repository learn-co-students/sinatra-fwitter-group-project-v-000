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

# SIGNUP FORM: send
  get '/users/signup' do
    redirect to "/tweets" if is_logged_in?(session)
    erb :'/registrations/signup'
  end

# SIGNUP FORM: get data and CREATE user
  post '/users/signup' do

    if params[:username] == "" || params[:email] == "" ||  params[:password] == ""
      redirect to '/users/signup'
    else
      if current_user(session)
        redirect to '/tweets/index'
      else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save # or @user.save!
      session[:id] = @user.id
      redirect to '/tweets/index'
      end
    end
  end

#LOGIN form SEND
  get '/sessions/login' do
    erb :'sessions/login'
  end

#LOGIN FORM: PULL IN data
  post '/users/login' do
    @user = User.find_by_username(params["username"])
      # , password: params["password"])-- no, bec password_diest

    if @user && @user.authenticate(params["password"])

      session[:user_id] = @user.id
      redirect 'tweets/index' # or users/index
    else
      redirect to '/users/login' # or message about trying again.error page?
    end
  end

#LOGOUT SEND FORM
  get '/users/logout' do
    erb :'sessions/logout'
  end

#LOGOUT execute
  post '/user/logout' do
    session.clear
    redirect to  '/'
  end

end
