class UserController < ApplicationController

  get '/signup' do
    erb :"/users/signup"
  end

  post '/signup' do
    @user = User.create(params)
    session[:id] = @user.id
    if @user.save
      redirect to "/tweets"
    else
      redirect to "/users/signup"
    end
  end

  get '/login' do

    erb :"/users/login"
  end

end
