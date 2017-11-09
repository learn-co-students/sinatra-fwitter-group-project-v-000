class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if validate_signup
      @user = User.new(params)
      if @user.save
        session[:user_id] = @user.id
        redirect "/tweets"
      else
        redirect "/signup"
      end
    else
      redirect "/signup"
    end
  end

  get '/login' do
    erb :"users/login"
  end

  post "/login" do
	  user = User.find_by(:username => params[:username])

	  if user && user.authenticate(params[:password])
		 session[:user_id] = user.id
		 redirect "/tweets"
	  else
		 redirect "/failure"
	  end
	end

end
