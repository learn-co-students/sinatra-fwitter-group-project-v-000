class UsersController < ApplicationController

  get "/signup" do
    binding.pry
      if is_logged_in?
        redirect to "/tweets"
      else 
        erb :'/users/create_user'
      end 
  end

  post "/signup" do
    if params[:username] == "" || params[:username] == nil
      redirect to "/signup"
    elsif params[:email] == "" || params[:email] == nil
      redirect to "/signup"
    elsif params[:password] == "" || params[:password] == nil
      redirect to "/signup"
    else 
      @user = User.create(username: params["username"], password: params["password"], email: params["email"])
      @user.save
      session[:user_id] = @user.id
      redirect to "/tweets"
    end
  end 
  
end
