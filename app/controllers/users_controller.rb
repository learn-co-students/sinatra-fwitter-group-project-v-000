class UsersController < ApplicationController

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
       redirect '/signup'
    else 
      user = User.create(params[:user])
      redirect '/login'
    end
  end

  get '/users/:slug' do
    if logged_in?
			erb :'/users/show'
		else
			redirect "/login"
		end
    
    @user = User.find(session[:user_id])
    erb :'/users/show'
  end


  get "/login" do
    erb :'/users/login'
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    
    if user && user.authenticate(params[:password])
       session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

end
