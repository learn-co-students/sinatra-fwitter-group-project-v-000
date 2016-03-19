class UsersController < ApplicationController

get "/signup" do
  erb :"users/create_user"
end

post "/signup" do
        user = User.new(params[:user])
        if user.save
            redirect "/login"
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
            redirect "/success"
        else
            redirect "/failure"
        end
    end

  get "/success" do
    @user = User.current_user
    if @user.logged_in?
      erb :success
    else
      redirect "/login"
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect to "/"
  end

end