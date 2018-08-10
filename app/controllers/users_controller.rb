require './app/helpers/helpers'
class UsersController < ApplicationController

  get "/signup" do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
      erb :'/users/new'
  end

  post "/signup" do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      user.save
      session[:user_id] = user.id
    else 
      redirect to '/signup'
    end
    redirect to '/tweets'
  end

  get "/login" do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :index
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/tweets"
		else
			redirect "/login"
		end
  end

  get "/users/:slug" do   
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get "/logout" do
    if Helpers.is_logged_in?(session)
      session.clear
    end
      redirect "/login"
  end
    
end
