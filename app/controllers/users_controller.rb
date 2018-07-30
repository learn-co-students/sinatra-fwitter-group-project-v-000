class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty?  || params[:password].empty?
      redirect '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email])
      @user.save
      session[:user_id] = @user.id
      binding.pry
      redirect '/tweets/index'
    end
  end

end
