require './config/environment'
require 'pry'
class UserController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end


get '/signup' do
  #binding.pry
  if logged_in? #revisit
    redirect to '/tweets'
  else
    erb :'/users/create_user'
  end
end

post '/signup' do
  if params["username"] != "" && params["email"] != "" && params["password"] != ""
    @user = User.create(params)
    @user.save
    session[:user_id] = @user.id
    redirect to '/tweets'
  end
  redirect to '/signup'
end

get '/login' do
  if logged_in?
    redirect to '/tweets'
  else
    erb :'/users/login'
  end
end

post '/login' do
  binding.pry
  @user = User.find_by(username: params[:username])
  session[:user_id] = @user.id
  redirect to '/tweets'
end

get '/logout' do
  #binding.pry
  session.clear
  redirect to '/login'
end

end
