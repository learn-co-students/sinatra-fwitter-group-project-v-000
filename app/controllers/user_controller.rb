class UserController < ApplicationController

  get '/signup' do
    erb :"users/create_user"
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      binding.pry
      redirect “/tweets”
    else
        # binding.pry
      redirect "/signup"
    end
  end

end
