class UsersController < ApplicationController
  get "/signup" do
    if !logged_in?
      erb :"/users/create_user"
    else
      redirect "/tweets"
    end
  end

  post "/signup" do
    if params[:username]== "" || params[:password] == "" || params[:email] ==""
      redirect "/signup"
    else
      User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      redirect '/tweets'
    end
    redirect '/tweets'
  end

  get "/login" do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    end
      redirect "/tweets"
    end
end
