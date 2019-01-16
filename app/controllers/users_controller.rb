class UsersController < ApplicationController

  get "/signup" do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
       redirect '/signup'
    else 
      user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      user.save 
      session[:user_id] = user.id
      redirect "/tweets"
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
     if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
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
