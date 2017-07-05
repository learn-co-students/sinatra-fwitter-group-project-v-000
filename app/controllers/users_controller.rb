class UsersController < ApplicationController
  use Rack::Flash

  get "/users/:id" do
    if logged_in?
      u = User.find_by_slug(params[:id])
      if(!u.nil?)
        @tweets = u.tweets
        erb :"/users/show"
      else
        flash[:message] = "no existing user"
        redirect "/tweets"
      end
    else
      flash[:message] = "Please Login"
      redirect "/login"
    end
  end

  get "/login" do
    logged_in? ? (redirect "/tweets") : (erb :"/users/login")
  end

  get "/logout" do
    session.destroy
    redirect "/login"
  end

  get "/signup" do
    logged_in? ? (redirect "/tweets") : (erb :"/users/create_user")
  end

  post "/login" do
    if(params[:username].empty? || params[:password].empty?)
      flash[:message] = "empty content"
      redirect "/login"
    else
      user = User.find_by(username: params[:username])
      if(!user.nil? && user.authenticate(params[:password]))
        session[:user_id] = user.id
        redirect "/tweets"
      else
        flash[:message] = "wrong password or username"
        redirect "/login"
      end
    end
  end

  post "/signup" do
    if(params[:username].empty? || params[:password].empty? || params[:email].empty?)
      flash[:message] = "error empty field"
      redirect "/signup"
    else
      session[:user_id] = User.create(username: params[:username], email: params[:email], password: params[:password]).id
      redirect "/tweets"
    end
  end
end
