require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
   set :session_secret, "secret"
 end

  get '/' do
    erb :'/tweets/homepage'
  end

  get '/signup' do
    if Helper.is_logged_in?(session)
      redirect "/tweets"
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
       flash[:message] = "oops, no information entered. Please try again!"
       redirect "/signup"
     end
     redirect :"/tweets"
   end

   get '/login' do
     if !Helper.is_logged_in?(session)
       erb :'/users/login'
     else
      redirect '/tweets'
    end
   end

   post '/login' do
    @user = User.find_by(username: params["username"])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      flash[:message] = "No username or password found. Please try again <3"
      erb :'/users/login'
    end
   end

   get '/logout' do
     session.clear
     redirect to '/login'
   end

end
