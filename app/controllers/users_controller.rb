class UsersController < ApplicationController

  get '/signup' do
    erb :signup
  end

  post '/signup' do 
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id 
      redirect '/tweets/index'
    else 
      redirect '/signup'
    end
  end

  

end
