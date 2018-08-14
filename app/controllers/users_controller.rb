require 'pry'
class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      #binding.pry
      redirect '/tweets'
    else
      #binding.pry
    erb :'users/signup'
  end
  end



  post '/signup' do
    if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
      @user = User.create(params)
      session[:user_id] = @user.id



      redirect  '/tweets'
      #binding.pry
    else
      redirect '/signup'
    end

  end


  get '/login' do
    erb :'users/login'
  end


  post '/login' do
    #binding.pry
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id

      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
