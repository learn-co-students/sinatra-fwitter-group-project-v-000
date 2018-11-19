class UsersController < ApplicationController

  get '/signup' do
    erb :signup
  end

  post '/users' do 
    if params[:name] != "" && params[:email] != "" && params[:password] != ""
      @user = User.create(params)
      session[:user_id] = @user.id 
      redirect '/tweets/index'
    else 
      redirect '/homepage'
    end
  end

  

end
