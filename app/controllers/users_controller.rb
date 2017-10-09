class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect to '/tweets'
    else
    erb :'users/create_user'
  end
  end

  post "/signup" do
    redirect "/signup" if params[:username] == ""
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get "/login" do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect to "/tweets"
      else
       redirect to "/login"
      end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect to '/login'
    else
    redirect to "/tweets"
  end
  end

end
