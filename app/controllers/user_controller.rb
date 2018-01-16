class UserController < ApplicationController

  get '/users' do
    @users = User.all
    erb :'/users/index'
  end

  get "/users/signup" do
		erb :signup
	end

  post "/users/signup" do
      user = User.new(:username => params[:username], :password => params[:password])

      if user.save
          redirect "/users/login"
      else
          redirect "/failure"
      end
  end

  post "/users/login" do
      user = User.find_by(:username => params[:username])
      if user
          redirect "/users/show"
      else
          redirect "/failure"
      end
  end

  post "/users/login" do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/users/show"
    else
        redirect "/failure"
    end
end

end
