class UsersController < ApplicationController

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save

    redirect to "/login"
  end

end
