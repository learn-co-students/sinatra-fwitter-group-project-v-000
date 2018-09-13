require 'pry'

class UsersController < ApplicationController

  get '/singnup' do
    erb :'users/signup'
  end

  post '/users' do
    @user = User.new
    @user = User.find_by(:username =>params[:username], :emamil =>params[:email], :password =>params[:password])
    if user.save
      redirect "/tweets"
    else
      redirect "/users/singnup"
    end
  end

post "login" do
  user = User.find_by(:username => params[:username], :password => params[:password])
  if user && user.authenticate(params[:password], params[:username])
    session[:user_id] =user.id
    redirect "/tweets"
  else
    redirect "/users/login"
  end
end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'users/show'
  end

end
