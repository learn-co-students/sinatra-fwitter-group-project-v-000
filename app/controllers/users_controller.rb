require 'rack-flash'

class UsersController < ApplicationController

get '/signup' do
  erb :"users/create_user"
end

get '/login' do
  erb :"users/login"
end

post '/signup' do
  @user = User.new(username: params[:username], email: params[:email], password: params[:password])
  if @user.save && @user.username != ""
    redirect '/login'
  else
#    flash[:message] = "Must include a username to signup." <-- not working, figure out flash messages later
    redirect '/'
  end
end

post '/login' do
  @user= User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/tweets'
  else
#    flash[:message] = "Incorrect username or passord. Please try again." <-- not working, figure out flash messages later
    redirect '/'
  end
end

end
