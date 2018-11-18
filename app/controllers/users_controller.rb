class UsersController < ApplicationController

  get '/signup' do
    erb :"users/signup"
  end

  post "/signup" do
		user = User.create(params)

    if user.save && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
		else
			redirect "/failure"
		end
	end

  get "/login" do
    erb :"users/login"
  end

  post "/login" do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

end
