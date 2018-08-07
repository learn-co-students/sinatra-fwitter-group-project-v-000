require 'pry'
class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end



  post '/signup' do

if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
  @user = User.create(params)
  session[:user_id] = @user.id

  redirect '/tweets'
else
  redirect '/signup'
end
end

  get '/users/home' do
    @user = User.find(session[:user_id])

    if @user
    erb :'users/home'
  else
    redirect '/'
  end
  end

end
