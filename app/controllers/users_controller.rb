class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect to "/tweets"
    end
    erb :"/users/create_user"
  end

  post "/signup" do
    if logged_in?
      redirect to "/tweets"
    end

    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to "/signup"
    else
      user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = user.id
      redirect to "/tweets"
    end

  end

  get "/login" do
    if logged_in?
      redirect to "/tweets"
    end
    erb :"/users/login"
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
     redirect to "/failure"
    end
  end

  get "/failure" do
    erb :"index"
  end

  #get "/logout" do
  #  if !logged_in?
  #    redirect to "/"
  #  end
  #  erb :"/users/logout"
  #end

  get "/logout" do
    if !logged_in?
        redirect to "/"
    end

    if logged_in?
      session.clear
      redirect to "/login"
    end
  end

  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"users/show"
  end

end
