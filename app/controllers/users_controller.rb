class UsersController < ApplicationController


  get '/signup' do
    erb :'/users/signup'
  end

  get '/login' do 
    erb :'/users/login'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end


end