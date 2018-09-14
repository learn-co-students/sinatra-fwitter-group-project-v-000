require 'pry'

class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    @user = User.create(:username =>params[:username], :emamil =>params[:email], :password =>params[:password])

    if @user.save
      redirect "/tweets/tweets"
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
  #  @user = User.find(params[:id])
    erb :'users/show'
  end

end
