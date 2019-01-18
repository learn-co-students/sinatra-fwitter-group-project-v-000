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
    erb :'signup'
  end

  post '/signup' do
    # can't get this to work: user = User.new(params[:user])
    user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if user.save && user.authenticate(params[:password])
      session[:user_id] = user
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

end

helpers do
  
end
