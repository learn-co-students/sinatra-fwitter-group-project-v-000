class UsersController < ApplicationController


  get '/signup' do
    if logged_in?
       redirect to "/tweets"
    else
      erb :'/users/create_user'
    end
  end

  post "/signup" do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save && user.username != "" && user.email != ""
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if logged_in?
       redirect to "/tweets"
    else
      erb :'/users/login'
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
#      binding.pry
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect to '/'
    end
  end

  get "/users/:slug" do
    @user = self.find_by_slug(params[:slug])
    erb :'/users/show'
  end

end
