class UserController < ApplicationController

    get '/signup' do
      erb :'users/create_user'
    end

    post '/signup' do

      if params["username"] == nil || params["username"] == ""
        redirect to "/signup"
      else
        @user = User.new
        @user.email = params["email"]
        @user.username = params["username"]
        @user.password_digest = params["password"]
        @user.save
      end

      redirect to "tweets/tweets"
    end

end
