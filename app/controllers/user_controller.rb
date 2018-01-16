class UserController < ApplicationController


  get "/signup" do
    if session[:user_id].empty?
  		erb :"users/create_user"
    else
      flash[:message] = "You are already logged in.  Please log-out first."
      redirect "/tweets"
    end
	end

  post "/signup" do
      user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])

      if user.save
          session[:user_id] = user.id
          redirect "/tweets"
      else
          flash[:message] = "Signup failure: please retry!"
          redirect "/signup"
      end
  end

  post "/login" do
      user = User.find_by(:username => params[:username])
      if user
        flash[:message] = "Welcome, #{user}"
        redirect "/users/show"
      else
        flash[:message] = "Successfully created..."
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
