class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else !!logged_in?
      redirect '/tweets'
    end
  end

  post "/signup" do
    user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
    if params[:email] == "" || params[:username] == "" || params[:password] == ""
      redirect '/signup'
    else
      user.save
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect "/tweets"
	  else
	    redirect "/signup"
	  end
  end


  get "/users/:slug" do
  #  if !!logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"users/show"
  #  else !logged_in?
  #    redirect '/login'
  #  end
  end


  get "/logout" do
    if !!logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/index"
    end
  end




end
