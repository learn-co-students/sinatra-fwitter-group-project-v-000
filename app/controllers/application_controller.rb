require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
   set :session_secret, "secret"
 end

  get '/' do
    erb 'Welcome to Fwitter'
  end

  get '/signup' do
    if session[:user_id] != nil
      redirect :"/tweets"
    else
      erb :'signup'
    end
  end

  post '/signup' do
     if params["username"] != "" && params["email"] != "" &&  params["password"] != ""

       @user = User.new(username: params["username"], email: params["email"], password: params["password"])
       @user.save
       session[:user_id] = @user.id
     else
       redirect :"/signup"
     end
     redirect :"/tweets"
   end

   get '/login' do
     erb :'/users/login'
   end
end
