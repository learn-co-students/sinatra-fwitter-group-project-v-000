require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb 'Welcome to Fwitter'
  end

  get '/signup' do
    erb :'signup'
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
end
