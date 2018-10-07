class UsersController < ApplicationController

  get '/signup' do
      erb :signup
  end

  # post '/signup' do
  #   if params[:username] == "" || params[:email] == "" || params[:password] == ""
  #     redirect '/signup'
  #   else
  #     @user = User.create(username: params[:username], email: params[:email], password: params[:password])
  #     session[:user_id] = @user.id
  #     redirect '/tweets'
  #   end
  # end

  get '/login' do
    erb :index
  end

  # post '/login' do
  #   @user = User.find_by(:username => params[:username])
  #   # if @user != nil && @user.password == params[:password]
  #   if logged_in?
  #     session[:user_id] = @user.id
  #     redirect to '/tweets'
  #   else
  #     redirect '/signup'
  #   end
  # end


end
