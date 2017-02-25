class UsersController < ApplicationController

    get "/signup" do
      erb :'users/signup'
    end

    post "/signup" do
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect to "/signup"
      else
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
        binding.pry
      redirect to "/tweets"
      end
    end


end
