class UsersController < ApplicationController
  get '/' do
    @users = User.all
    erb :index
  end
  
  # get '/users/index' do
  #   @users = User.create(username: params[:username], email: params[:email], password: params[:password])
  #   erb :'/users/index'
  # end
  
  get "users/signup" do
    erb :signup
  end

  post 'users/new' do
    if params[:username] == "" || params[:password] == ""
      redirect '/failure'
    else
      User.create(username: params[:username], password: params[:password])
      redirect '/login'
    end
  end
end
