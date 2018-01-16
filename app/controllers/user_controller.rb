class UserController < ApplicationController

  get "/signup" do
    if session[:user_id].nil?
  		erb :'users/create_user'
    else
      flash[:message] = "You are already logged in.  Please log-out first."
      redirect "/tweets"
    end
	end

  post "/signup" do
    # binding.pry
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      flash[:message] = "Signup failure: please retry!"
      redirect "/signup"
    end
  end

  get "/login" do
    if session[:user_id].nil?
      erb :"users/login"
    else
      flash[:message] = "You are already logged in.  Please log-out first."
      redirect "/tweets"
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
    else
      flash[:message] = "Login failure. Please login again."
      redirect "/login"
    end
  end

  get '/logout' do
    if session[:user_id].nil?
      redirect '/'
    else
      session[:user_id] = nil
      redirect "/login"
    end
  end

end
